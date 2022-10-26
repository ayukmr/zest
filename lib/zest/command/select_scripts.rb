module Zest
  module Command
    class << self
      # select scripts to run from list
      def select_scripts
        scripts = yaml_glob.filter(&:scripts?)

        prompt = TTY::Prompt.new(
          interrupt: :exit,
          symbols: {
            marker:    '>'.cyan,
            radio_on:  '[*]',
            radio_off: '[ ]'
          }
        )

        prompt_scripts =
          scripts.flat_map do |yaml|
            yaml.script_names.map do |name|
              "#{yaml.name}:#{name}"
            end
          end

        # show prompt
        chosen = prompt.multi_select(
          "#{'run scripts'.magenta.bold} –",
          prompt_scripts,
          help: 'up/down/space/enter',
          per_page: prompt_scripts.length
        )

        puts

        chosen.each do |chosen|
          # find script by name
          name, script = chosen.split(':')
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
