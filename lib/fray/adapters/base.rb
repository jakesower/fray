#
# The adapter is responsible for taking in a raw HTTP request an producing a
# normalized hash for consumption by a querier object. It can (and should) be
# used to validate user input.
#
module Fray::Adapters
  class Base
    STAGES = ['adapt', 'validate', 'serialize']

    def initialize(schema, hooks={})
      @schema = schema
      super(hooks)
    end


  private

    def adapt; ->(x) { x }; end
    def validate; ->(x) { x }; end

    def serialize
      ->(x) { Fray::Query.new }
    end
  end
end
