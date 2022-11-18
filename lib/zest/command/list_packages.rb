module Zest
  module Command
    # list packages
    def self.list_packages
      packages = yaml_glob.filter(&:packages?)

      puts "#{'Packages'.magenta.bold}:"
      print '  '

      # show packages
      packages.each_with_index do |packages, index|
        print "#{packages.name.cyan}, "

        if ((index + 1) % 5).zero?
          puts
          print '  '
        end
      end
    end
  end
end
