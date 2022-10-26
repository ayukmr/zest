module Zest
  module Command
    class << self
      # run script from yaml
      def run_script(args)
        scripts = yaml_glob.filter(&:scripts?)

        error 'no scripts given', 1 if args.empty?

        args.each do |arg|
          # find script by name
          name, script = arg.split(':')
          yaml = scripts.find { |yaml| yaml.name == name }

          if yaml&.script?(script)
            # run script
            yaml.run_script(script)
            puts
          else
            error "script `#{script}` not found for `#{name}`", 1
          end
        end
      end
    end
  end
end
