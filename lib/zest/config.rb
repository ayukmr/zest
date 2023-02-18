module Zest
  # local and global config
  class Config
    # create config from yaml
    def initialize
      global_path = File.join(
        XDG::Config.new.home.to_s,
        'zest/config.yml'
      )

      if exists?(global_path)
        begin
          # global config
          @global = Psych.load_file(global_path)
        rescue Psych::Exception
          error 'malformed global config', 1
        end

        error 'global config does not conform to schema', 1 \
          unless Zest::Schema.global?(@global)
      end

      root_path = File.join(config_path, '.zest.yml')

      begin
        # root config
        @root = Psych.load_file(root_path)
      rescue Psych::Exception
        error 'malformed root config', 1
      end

      error 'root config does not conform to schema', 1 \
        unless Zest::Schema.root?(@root)

      # use defaults
      @global ||= {}
      @root   ||= {}
    end

    # get bootstrap file
    def bootstrap_file
      coalesce(@root['file'], 'bootstrap.yml')
    end

    # check if files should be passed through erb
    def erb?
      coalesce(@root['erb'], false)
    end

    # check if errors should be verbose
    def verbose?
      coalesce(@global['verbose'], false)
    end

    # check if links and copies should be forced
    def force?
      coalesce(@global['force'], 1)
    end

    # check if error should be shown on non-zero exit
    def shell_error?
      coalesce(@global['shell_error'], 1)
    end
  end
end
