module Zest
  # yaml from files
  class YAML
    include Zest::Run

    # create zest yaml
    def initialize(file)
      config = Zest::Config.new

      @file = file

      if config.erb?
        # load with erb
        data = ERB.new(File.open(@file).read).result
        @data = Psych.load(data)
      else
        @data = Psych.load_file(@file)
      end

      error "bootstrap for #{name} does not conform to schema", 1 \
        unless Zest::Schema.bootstrap?(@data)
    rescue Psych::Exception => error
      # catch errors
      error "cannot parse #{name} bootstrap: #{error}", 1
    end

    # get yaml name
    def name
      File.basename(File.dirname(@file))
    end

    # get directory path
    def dir_path
      File.dirname(@file)
    end

    # check if yaml has config
    def config?
      @data.key?('config')
    end

    # check if yaml has packages
    def packages?
      @data.key?('packages')
    end

    # check if yaml has scripts
    def scripts?
      @data.key?('scripts')
    end

    # check if yaml has certain script
    def script?(script)
      scripts? && @data['scripts'].key?(script)
    end

    # get all scripts
    def script_names
      @data['scripts'].keys
    end

    # run config from yaml
    def run_config
      run_config_hash(@data['config'], name)
    end

    # run packages from yaml
    def run_packages
      run_packages_hash(@data['packages'], name)
    end

    # run script from yaml
    def run_script(script)
      puts "running #{name}:#{script}".magenta.bold
      run_config_hash(@data['scripts'][script])
    end
  end
end
