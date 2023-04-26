module Zest
  module Command
    # show help for packages
    def self.packages_help
      # show message
      puts <<~HELP
        #{'usage'.magenta.bold}:
          #{'zest packages'.blue} #{'<command>'.yellow}

        #{'commands'.magenta.bold}:
          #{'run'.blue} #{'<packages>'.yellow}  run packages from yaml
          #{'select'.blue}          select packages from list
          #{'list'.blue}            list packages
          #{'help'.blue}            show this message
      HELP
    end
  end
end
