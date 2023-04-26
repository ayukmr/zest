module Zest
  module Command
    # show help for script
    def self.script_help
      # show message
      puts <<~HELP
        #{'usage'.magenta.bold}:
          #{'zest script'.blue} #{'<command>'.yellow}

        #{'commands'.magenta.bold}:
          #{'run'.blue} #{'<script>'.yellow}  run script from yaml
          #{'select'.blue}        select scripts from list
          #{'list'.blue}          list scripts
          #{'help'.blue}          show this message
      HELP
    end
  end
end
