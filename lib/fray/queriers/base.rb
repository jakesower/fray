#
# The querier is responsible for sending a query to the data store and
# normalizing the result.
#
module Fray::Queriers
  class Base < Fray::StageRunner
    STAGES = ['adapt', 'serialize']

    def initialize(schema, hooks={})
      @schema = schema
      super(hooks)
    end


  private

    def adapt; ->(x) { x }; end

    def serialize
      ->(x) { Fray::Query.new }
    end
  end
end
