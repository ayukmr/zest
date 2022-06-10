module Zest
  module Command
    class << self
      # show help for script
      def script_help
        # show message
        puts <<~HELP
          #{'Usage'.magenta.bold}:
            #{'zest script'.cyan} #{'<COMMAND>'.yellow}

          #{'Commands'.magenta.bold}:
            #{'run'.cyan} #{'<SCRIPT>'.yellow}  run script from yaml
            #{'select'.cyan}        select scripts from list
            #{'list'.cyan}          list scripts
            #{'help'.cyan}          show this message
        HELP
      end
    end
  end
end
