module Zest
  module Command
    class << self
      # run packages from yaml
      def run_packages(args)
        packages = yaml_glob.filter(&:packages?)

        error 'no packages given', 1 if args.empty?

        args.each do |name|
          # find packages by name
          yaml = packages.find { |yaml| yaml.name == name }

          if yaml
            # run packages
            yaml.run_packages
            puts
          else
            error "packages not found for `#{name}`", 1
          end
        end
      end
    end
  end
end
