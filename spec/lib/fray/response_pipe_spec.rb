require 'spec_helper'

RSpec.describe Fray::ResponsePipe do
  context 'with some functions' do
    subject(:pipe) { Fray::ResponsePipe.new }
    let(:response) {
      Fray::Response.new(
        code: 200,
        headers: {},
        body: ''
      )
    }

    it 'runs a sequence of functions' do
      result = pipe.
        then(->(x) { x * 2 }).
        then(->(x) { x + 5 }).
        run(1)

      expect(result).to eq(7)
    end


    it 'is immutable' do
      p2 = pipe.then(->(x) { x * 2 })

      expect(pipe.run(1)).to eq(1)
      expect(p2.run(1)).to eq(2)
    end


    it 'is reusable' do
      p = pipe.
        then(->(x) { x * 2 }).
        then(->(x) { x + 5 })

      expect(p.run(1)).to eq(7)
      expect(p.run(2)).to eq(9)
    end


    it 'aborts on getting a Fray::Response' do
      result = pipe.
        then(->(x) { x * 2 }).
        then(->(_) { response }).
        then(->(_) { 1 }).
        run(1)

      expect(result).to be_instance_of(Fray::Response)
    end


    it 'catches Fray::Responses' do
      result = pipe.
        then(->(x) { x * 2 }).
        then(->(_) { response }).
        then(->(_) { raise "don't get here" }).
        catch(->(_) { 'Inferno' }).
        run(1)

      expect(result).to eq('Inferno')
    end


    it "doesn't invoke catch if no Fray::Response is encountered" do
      result = pipe.
        then(->(x) { x * 2 }).
        then(->(_) { 'Haven' }).
        catch(->(_) { 'Inferno' }).
        run(1)

      expect(result).to eq('Haven')
    end
  end
end
