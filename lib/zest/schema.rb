module Zest
  # schema for zest
  module Schema
    class << self
      # test bootstrap file against schema
      def bootstrap?(data)
        schema = JSON.parse(File.read(File.expand_path(
          './schema/bootstrap.json', __dir__
        )))

        JSON::Validator.validate(schema, data)
      end

      # test root config against schema
      def root?(data)
        schema = JSON.parse(File.read(File.expand_path(
          './schema/root.json', __dir__
        )))

        JSON::Validator.validate(schema, data)
      end

      # test global config against schema
      def global?(data)
        schema = JSON.parse(File.read(File.expand_path(
          './schema/global.json', __dir__
        )))

        JSON::Validator.validate(schema, data)
      end
    end
  end
end
