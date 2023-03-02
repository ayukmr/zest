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
          #{'Usage'.magenta.bold}:
            #{'zest'.cyan} #{'<command>'.yellow}

          #{'Commands'.magenta.bold}:
            #{'config'.cyan}   #{'<subcommand>'.yellow}  interact with configs
            #{'packages'.cyan} #{'<subcommand>'.yellow}  interact with packages
            #{'script'.cyan}   #{'<subcommand>'.yellow}  interact with scripts

            #{'help'.cyan} #{'<command>'.yellow}  get help for a command
            #{'help'.cyan}            show this message
        HELP

        exit 0
      end
    end
  end
end
