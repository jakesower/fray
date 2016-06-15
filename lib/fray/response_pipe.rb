#
# Monad for handling errors as part of a chain of functions. Works much like
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
  class ResponsePipe
    def initialize(thens = [], c = nil)
      @thens = thens
      @catch = c || ->(x) { x }
    end


    def then(func, *args)
      new_then = {
        function: func,
        args: args
      }

      ResponsePipe.new(@thens + [new_then], @catch)
    end


    def catch(func)
      ResponsePipe.new(@thens, func)
    end


    def run(state = nil, thens = @thens)
      if thens.empty?
        state
      else
        first, rest = thens[0], thens[1..-1]
        next_state = first[:function].call(state, *first[:args])

        next_state.is_a?(Fray::Response) ?
          @catch.call(next_state) :
          run(next_state, rest)
      end
    end

  end
end
