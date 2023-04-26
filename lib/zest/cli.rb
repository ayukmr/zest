# load commands
Dir[File.expand_path(
  './command/*.rb', __dir__
)].each { |file| require file }

module Zest
  # zest cli
  module CLI
    class << self
      # run cli with argv
      def run(argv)
        command, subcommand, *args = argv

        # help command
        help if (command == 'help' && !subcommand) || !command

        Zest::Command.run(command, subcommand, args)
      end

      # show help and exit
      def help
        puts <<~HELP
          #{'usage'.magenta.bold}:
            #{'zest'.blue} #{'<command>'.yellow}

          #{'commands'.magenta.bold}:
            #{'config'.blue}   #{'<subcommand>'.yellow}  interact with configs
            #{'packages'.blue} #{'<subcommand>'.yellow}  interact with packages
            #{'script'.blue}   #{'<subcommand>'.yellow}  interact with scripts

            #{'help'.blue} #{'<command>'.yellow}  get help for a command
            #{'help'.blue}            show this message
        HELP

        exit 0
      end
    end
  end
end
