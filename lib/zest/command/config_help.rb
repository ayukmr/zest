module Zest
  module Command
    # show help for config
    def self.config_help
      # show message
      puts <<~HELP
        #{'usage'.magenta.bold}:
          #{'zest config'.blue} #{'<command>'.yellow}

        #{'commands'.magenta.bold}:
          #{'run'.blue} #{'<config>'.yellow}  run config from yaml
          #{'select'.blue}        run configs from list
          #{'list'.blue}          list configs
          #{'help'.blue}          show this message
      HELP
    end
  end
end
