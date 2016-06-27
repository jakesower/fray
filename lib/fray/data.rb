#
# This module simply reads the files in data_structures and reifies them as
# Structs with on-creation validations. The data strcture files use JSON schema
# for a format: http://json-schema.org
#
module Fray::Data
  class Base < OpenStruct
    def initialize(hash)
      if VALIDATOR.(hash)
        super(hash)
        self.freeze
      else
        e = "#{hash.inspect} failed schema validation:\n\n" +
            ERROR_GENERATOR.(hash).join("\n")
        raise ArgumentError, e
      end
    end
  end


  #
  # Do the dirty work of compiling the data JSON.
  #
  dir = File.dirname(File.expand_path(__FILE__))
  Dir["#{dir}/data_structures/*.json"].each do |path|
    file_name = File.basename(path, '.json')
    schema = JSON.parse(File.read(path))

    validator = JSON::Validator.method(:validate).curry[schema]
    error_generator = JSON::Validator.method(:fully_validate).curry[schema]

    klass = Class.new(Base) do
      VALIDATOR = validator
      ERROR_GENERATOR = error_generator

      def initialize(hash)
        super(hash)
      end
    end

    const_name = file_name.
      split('_').
      map{|chunk| chunk[0].upcase + chunk[1..-1]}.
      join('')

    Fray::Data.const_set(const_name.to_sym, klass)
  end
end
