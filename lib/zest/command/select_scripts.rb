module Zest
  module Command
    # select scripts to run from list
    def self.select_scripts
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

      chosen.each do |chsn|
        # find script by name
        name, script = chsn.split(':')
        yaml = scripts.find { |yml| yml.name == name }

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
