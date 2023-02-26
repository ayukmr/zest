module Zest
  module Command
    # show help for script
    def self.script_help
      # show message
      puts <<~HELP
        #{'Usage'.magenta.bold}:
          #{'zest script'.cyan} #{'<command>'.yellow}

        #{'Commands'.magenta.bold}:
          #{'run'.cyan} #{'<script>'.yellow}  run script from yaml
          #{'select'.cyan}        select scripts from list
          #{'list'.cyan}          list scripts
          #{'help'.cyan}          show this message
      HELP
    end
  end
end
