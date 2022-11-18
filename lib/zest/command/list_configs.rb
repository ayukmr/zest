module Zest
  module Command
    # list configs
    def self.list_configs
      configs = yaml_glob.filter(&:config?)

      puts "#{'Configs'.magenta.bold}:"
      print '  '

      # show configs
      configs.each_with_index do |config, index|
        print "#{config.name.cyan}, "

        if ((index + 1) % 5).zero?
          puts
          print '  '
        end
      end
    end
  end
end
