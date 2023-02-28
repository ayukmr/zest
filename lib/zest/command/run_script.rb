module Zest
  module Command
    # run script from yaml
    def self.run_script(args)
      error 'no scripts given' if args.empty?
      scripts = yaml_glob.filter(&:scripts?)

      args.each do |arg|
        # find script by name
        name, script = arg.split(':')
        yaml = scripts.find { |yml| yml.name == name }

        if yaml&.script?(script)
          # run script
          yaml.run_script(script)
          puts
        else
          error "script `#{script}` not found for `#{name}`"
        end
      end
    end
  end
end
