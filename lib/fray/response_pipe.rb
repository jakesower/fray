#
# Functor for handling errors as part of a chain of functions. Works much like
# the pipe operator |> from Elixir, but also handles responses. If a function
# within a `then` returns a Fray::Response (or subclass thereof), the
# remainder of the pipe will not be used. Rather, the `catch` function will be
# called (like with a JS promise). This function defaults to the identity
# function.
#
# Anything that responds to #call can be passed to `then` or `catch` as an
# argument, including vanilla lambdas.
#
# Examples:
#
# FunctionPipe.new.
#   then(->(x) { x + 1 }).
#   then(->(x, y) { x * y }, 2). # note how extra params are handled
#   catch(->(_) { 5 })
#   run(4)
#
# Returns 10
#
# FunctionPipe.new.
#   then(->(x) { Fray::Response.new('hi') }).
#   then(->(x) { x * 2 }).
#   catch(->(_) { 5 })
#   run(4)
#
# Returns 5
#
module Fray
  class ResponsePipe < AbortablePipe
    def initialize(thens = [], c = nil)
      abort_predicate = ->(state) { state.is_a?(Fray::Data::Response) }
      super(abort_predicate, thens, c)
    end

  end
end
