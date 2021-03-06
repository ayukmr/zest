module Zest
  module Command
    class << self
      # show help for config
      def config_help
        # show message
        puts <<~HELP
          #{'Usage'.magenta.bold}:
            #{'zest config'.cyan} #{'<COMMAND>'.yellow}

          #{'Commands'.magenta.bold}:
            #{'run'.cyan} #{'<CONFIG>'.yellow}  run config from yaml
            #{'select'.cyan}        run configs from list
            #{'list'.cyan}          list configs
            #{'help'.cyan}          show this message
        HELP
      end
    end
  end
end
