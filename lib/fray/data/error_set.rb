#
# This module simply reads the files in data_structures and reifies them as
# Structs with on-creation validations. The data strcture files use JSON schema
# for a format: http://json-schema.org
#
module Fray::Data
  class ErrorSet < Array
    def initialize(array)
      if array.all?{|elt| elt.is_a?(Fray::Data::Error)}
        super(array)
        self.freeze
      else
        msg = "All elements of a Fray::Data::ErrorSet must be instances of Fray::Data::Error. Got: #{array.inspect}"

        raise ArgumentError, msg
      end
    end
  end
end
