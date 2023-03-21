module Zest
  module Command
    # show help for packages
    def self.packages_help
      # show message
      puts <<~HELP
        #{'usage'.magenta.bold}:
          #{'zest packages'.cyan} #{'<command>'.yellow}

        #{'commands'.magenta.bold}:
          #{'run'.cyan} #{'<packages>'.yellow}  run packages from yaml
          #{'select'.cyan}          select packages from list
          #{'list'.cyan}            list packages
          #{'help'.cyan}            show this message
      HELP
    end
  end
end
