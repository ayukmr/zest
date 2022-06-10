module Zest
  module Command
    class << self
      # select packages to run from list
      def select_packages
        packages = yaml_glob.filter(&:packages?)

        prompt = TTY::Prompt.new(
          interrupt: :exit,
          symbols: {
            marker:    '>'.cyan,
            radio_on:  '[*]',
            radio_off: '[ ]'
          }
        )

        # show prompt
        chosen = prompt.multi_select(
          "#{'run packages'.magenta.bold} –",
          packages.map(&:name),
          help: 'up/down/space/enter',
          per_page: packages.length
        )

        puts

        chosen.each do |name|
          # find packages by name
          yaml = packages.find { |yaml| yaml.name == name }

          if yaml
            # run packages
            yaml.run_packages
            puts
          else
            error("packages not found for `#{name}`", 1)
          end
        end
      end
    end
  end
end
