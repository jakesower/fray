#
# The stage runner will 
#
module Fray
  class StageRunner
    IDENTITY = ->(x) { x }

    def initialize(stages=[], hooks={})
      @stages = stages
      @hooks = hooks
    end


    def call(state)
      pipe = @stages.reduce(ResponsePipe.new) do |pipe, stage|
        add_stage(pipe, stage)
      end

      pipe.run(state)
    end


  private

    #
    # Run before_stage, stage, after_stage in order
    #
    # If a hook is defined in a @hook, use it. If not there, try an instance
    # method. If still not there do nothing.
    #
    def add_stage(pipe, stage)
      ["before_#{stage}", stage, "after_#{stage}"].reduce(pipe) do |memo, hook|
        stage_hook(memo, hook)
      end
    end


    def stage_hook(pipe, hook)
      if @hooks.has_key?(hook)
        pipe.then(@hooks["#{rel}_#{stage}"])

      elsif respond_to?(hook)
        pipe.then(method(hook))

      else
        pipe

      end

    end
  end
end
