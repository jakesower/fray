#
# This module simply reads the files in data_structures and reifies them as
# Structs with on-creation validations. The data strcture files use JSON schema
# for a format: http://json-schema.org
#
module Fray::Data
  class Base < OpenStruct
    def initialize(hash)
      if JSON::Validator.validate(__schema, hash)
        super(JSON.parse(JSON.generate(hash)))
        self.freeze
      else
        e = "#{hash.inspect} failed schema validation:\n\n" +
            JSON::Validator.fully_validate(__schema, hash).join("\n")
        raise ArgumentError, e
      end
    end
  end


  def self.define_schema_class(name, schema)
    const_name = name.split('_').map{|chunk| chunk[0].upcase + chunk[1..-1]}.join('')
    klass = Class.new(Base) do
      define_method :__schema do
        schema
      end
    end

    Fray::Data.const_set(const_name.to_sym, klass.freeze)
  end
end


#
# Run through the json schemas and compile them
#
dir = File.dirname(File.expand_path(__FILE__))
Dir["#{dir}/data_structures/*.json"].each do |path|
  file_name = File.basename(path, '.json')
  Fray::Data.define_schema_class(file_name, JSON.parse(File.read(path)))
end
