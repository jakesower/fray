#
# The responder is responsible for taking a normalized querier value and
# producting an HTTP response based on it. It also should respond to #respond
# which is used in case on a HttpResponse object.
#
module Fray::Adapters
  class Base < Fray::StageRunner
    STAGES = ['adapt', 'validate', 'normalize']

    def initialize(schema, hooks={})
      @schema = schema
      super(hooks)
    end


  private

    def adapt; ->(x) { x }; end
    def validate; ->(x) { x }; end

    def normalize
      ->(x) { Fray::Query.new }
    end
  end
end
