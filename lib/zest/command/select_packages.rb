module Zest
  module Command
    # select packages to run from list
    def self.select_packages
      packages = yaml_glob.filter(&:packages?)

      prompt = TTY::Prompt.new(
        interrupt: :exit,
        symbols: {
          marker:    '>'.blue,
          radio_on:  '[*]',
          radio_off: '[ ]'
        }
      )

      # show prompt
      chosen = prompt.multi_select(
        "#{'run packages'.magenta.bold} –",
        packages.map(&:name),
        help: 'up/down/space/enter',
        per_page: 20
      )

      puts

      chosen.each do |name|
        # find packages by name
        yaml = packages.find { |yml| yml.name == name }

        if yaml
          # run packages
          yaml.run_packages
          puts
        else
          error "packages not found for `#{name}`"
        end
      end
    end
  end
end
