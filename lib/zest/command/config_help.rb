module Zest
  module Command
    # show help for config
    def self.config_help
      # show message
      puts <<~HELP
        #{'usage'.magenta.bold}:
          #{'zest config'.cyan} #{'<command>'.yellow}

        #{'commands'.magenta.bold}:
          #{'run'.cyan} #{'<config>'.yellow}  run config from yaml
          #{'select'.cyan}        run configs from list
          #{'list'.cyan}          list configs
          #{'help'.cyan}          show this message
      HELP
    end
  end
end
