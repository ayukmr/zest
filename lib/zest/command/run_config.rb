module Zest
  module Command
    # run config from yaml
    def self.run_config(args)
      error 'no configs given' if args.empty?
      configs = yaml_glob.filter(&:config?)

      args.each do |name|
        # find config by name
        yaml = configs.find { |yml| yml.name == name }

        if yaml
          # run config
          yaml.run_config
          puts
        else
          error "config not found for `#{name}`"
        end
      end
    end
  end
end
