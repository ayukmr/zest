module Zest
  module Command
    class << self
      # run packages from yaml
      def run_packages(args)
        error 'no packages given', 1 if args.empty?
        packages = yaml_glob.filter(&:packages?)

        args.each do |name|
          # find packages by name
          yaml = packages.find { |yml| yml.name == name }

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
