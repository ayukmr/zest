module Zest
  module Command
    class << self
      # show help for script
      def list_scripts
        scripts = yaml_glob.filter(&:scripts?)

        puts "#{'Scripts'.magenta.bold}:"
        print '  '

        index = 0

        scripts.each do |yaml|
          # loop through scripts
          yaml.script_names.each do |script|
            index += 1

            # display script
            print "#{yaml.name.cyan}:#{script.cyan}, "

            if ((index + 1) % 5).zero?
              puts
              print '  '
            end
          end
        end
      end
    end
  end
end
