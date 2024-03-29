module Zest
  module Command
    # select configs to run from list
    def self.select_configs
      configs = yaml_glob.filter(&:config?)

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
        "#{'run configs'.magenta.bold} –",
        configs.map(&:name),
        help: 'up/down/space/enter',
        per_page: 20
      )

      puts

      chosen.each do |name|
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
