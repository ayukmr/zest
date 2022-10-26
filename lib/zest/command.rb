module Zest
  # command for cli
  module Command
    class << self
      # run command
      def run(command, subcommand, args)
        # commands and methods
        commands = {
          config: {
            run:    method(:run_config),
            list:   method(:list_configs),
            select: method(:select_configs)
          },
          packages: {
            run:    method(:run_packages),
            list:   method(:list_packages),
            select: method(:select_packages)
          },
          script: {
            run:    method(:run_script),
            list:   method(:list_scripts),
            select: method(:select_scripts)
          },
          help: {
            config:   method(:config_help),
            packages: method(:packages_help),
            script:   method(:script_help)
          }
        }

        command_hash = commands[command.to_sym]

        if command_hash.nil?
          error "command `#{command}` does not exist", 1
        elsif subcommand.nil?
          # show help for command
          commands[:help][command.to_sym][]
        elsif command_hash[subcommand.to_sym].nil?
          error "subcommand `#{subcommand}` does not exist for `#{command}`", 1
        elsif subcommand == 'help'
          # show help for command
          commands[:help][command.to_sym][]
        else
          # run command
          run_command(command_hash[subcommand.to_sym], args)
        end
      end

      private

      # run command method
      def run_command(method, args)
        # pass args if method takes args
        if method.arity.zero?
          method[]
        else
          method[args]
        end
      end

      # glob files into YAML
      def yaml_glob
        Dir[glob_path].map do |file|
          Zest::YAML.new(file)
        end
      end
    end
  end
end
