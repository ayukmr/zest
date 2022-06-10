module Zest
  module Command
    class << self
      # show help for packages
      def packages_help
        # show message
        puts <<~HELP
          #{'Usage'.magenta.bold}:
             #{'zest packages'.cyan} #{'<COMMAND>'.yellow}

           #{'Commands'.magenta.bold}:
             #{'run'.cyan} #{'<PACKAGES>'.yellow}  run packages from yaml
             #{'select'.cyan}          select packages from list
             #{'list'.cyan}            list packages
             #{'help'.cyan}            show this message
        HELP
      end
    end
  end
end
