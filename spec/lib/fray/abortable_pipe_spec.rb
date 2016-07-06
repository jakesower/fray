require 'spec_helper'

RSpec.describe Fray::ResponsePipe do
  context 'with some functions' do
    subject(:pipe) { Fray::AbortablePipe.new(->(x) { x % 2 == 0 }) }

    it 'runs a sequence of functions' do
      result = pipe.
        then(->(x) { x + 2 }).
        then(->(x) { x * 5 }).
        run(1)

      expect(result).to eq(15)
    end


    it 'is immutable' do
      p2 = pipe.then(->(x) { x * 3 })

      expect(pipe.run(1)).to eq(1)
      expect(p2.run(1)).to eq(3)
    end


    it 'is reusable' do
      p = pipe.
        then(->(x) { x + 2 })

      expect(p.run(1)).to eq(3)
      expect(p.run(3)).to eq(5)
    end


    it 'aborts when the predicate is true' do
      result = pipe.
        then(->(_) { 0 }).
        then(->(_) { 1 }).
        run

      expect(result).to eq(0)
    end


    it 'catches even numbers' do
      result = pipe.
        then(->(x) { x * 2 }).
        then(->(_) { raise "don't get here" }).
        catch(->(_) { 'Inferno' }).
        run(1)

      expect(result).to eq('Inferno')
    end


    it "doesn't invoke catch if no even numbers are encountered" do
      result = pipe.
        then(->(x) { x * 3 }).
        then(->(_) { 'Haven' }).
        catch(->(_) { 'Inferno' }).
        run(1)

      expect(result).to eq('Haven')
    end
  end
end
