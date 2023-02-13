module Zest
  # run config or packages
  module Run
    # run config hash
    def run_config_hash(hash, name = nil)
      puts "running #{name} config".magenta.bold if name

      # run functions for keys
      hash_do(hash, 'dirs')  { |dir|  ensure_dir(dir)   }
      hash_do(hash, 'files') { |item| create_file(item) }
      hash_do(hash, 'link')  { |pair| link_file(pair)   }
      hash_do(hash, 'copy')  { |pair| copy_file(pair)   }
      hash_do(hash, 'shell') { |cmd|  shell_cmd(cmd)    }
      hash_do(hash, 'test')  { |pair| on_test(pair)     }
    end

    # run packages hash
    def run_packages_hash(hash, name)
      puts "running #{name} packages".magenta.bold

      run_config_hash(hash['setup']) if hash.key?('setup')

      hash_do(hash, 'packages') do |pair|
        config = Zest::Config.new
        command, packages = pair.first

        packages.each do |package|
          status("packaging #{package}") do
            command_args = Shellwords.split(command)
            package_args = Shellwords.split(package)

            _, _, status = Open3.capture3(*command_args, *package_args)

            # throw error on non zero exit
            if config.shell_error? && !status.success?
              raise \
                StandardError,
                "`#{command_args.join(' ')} #{package_args.join(' ')}` exited #{status.exitstatus}"
            end
          end
        end
      end
    end

    # get status of a block
    def status(message, &block)
      config = Zest::Config.new

      # spinner for tasks
      spinner = TTY::Spinner.new(
        ":spinner #{message.cyan}",
        frames: %w[⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏].map(&:yellow).map(&:bold),

        success_mark: '✓'.green.bold,
        error_mark:   '✗'.red.bold
      )

      spinner.run do |spinner|
        block.call
        spinner.success
      rescue => error
        spinner.error
        error error if config.verbose?
      end
    end

    # ensure a dir exists
    def ensure_dir(dir)
      dir = File.expand_path(dir)
      return if Dir.exist?(dir)

      status("creating #{tilde(dir)}") do
        FileUtils.mkdir_p(dir)
      end
    end

    # create and write file
    def create_file(file)
      if file.is_a?(Hash)
        file, text = file.first
        file = File.expand_path(file)

        # create and write file
        status("creating and writing to #{tilde(file)}") do
          File.delete(file) if exists?(file)
          File.write(file, text)
        end
      else
        file = File.expand_path(file)

        unless File.exist?(file)
          # create file
          status("creating #{tilde(file)}") do
            FileUtils.touch(file)
          end
        end
      end
    end

    # link file
    def link_file(pair)
      dest, src = pair.first

      src  = File.expand_path(src, dir_path)
      dest = File.expand_path(dest)

      remove_file(src, dest)

      status("linking #{tilde(src)} to #{tilde(dest)}") do
        FileUtils.ln_s(src, dest)
      end
    end

    # copy file
    def copy_file(pair)
      dest, src = pair.first

      src  = File.expand_path(src, dir_path)
      dest = File.expand_path(dest)

      remove_file(src, dest)

      status("copying #{tilde(src)} to #{tilde(dest)}") do
        FileUtils.cp(src, dest)
      end
    end

    # run shell command
    def shell_cmd(command)
      config = Zest::Config.new

      if command.is_a?(Hash)
        command, description = command.first
      else
        description = "running `#{command}`"
      end

      status(description) do
        _, _, status = Open3.capture3(command)

        # throw error on non zero exit
        raise StandardError, "`#{command}` exited #{status.exitstatus}" \
          if config.shell_error? && !status.success?
      end
    end

    # run hash on successful test
    def on_test(pair)
      test, config = pair.first
      _, _, status = Open3.capture3(test)

      # run if exit status is 0
      run_config_hash(config) if status.success?
    end
  end
end
