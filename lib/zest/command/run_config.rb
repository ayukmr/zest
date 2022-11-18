module Zest
  module Command
    # run config from yaml
    def self.run_config(args)
      error 'no configs given', 1 if args.empty?
      configs = yaml_glob.filter(&:config?)

      args.each do |name|
        # find config by name
        yaml = configs.find { |yaml| yaml.name == name }

        if yaml
          # run config
          yaml.run_config
          puts
        else
          error "config not found for `#{name}`", 1
        end
      end
    end
  end
end
