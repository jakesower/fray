require 'spec_helper'

RSpec.describe Fray::Data do
  context "A Fray::Response" do
    it "works with good inputs" do
      r = Fray::Data::Response.new(
        status: '200',
        headers: {},
        body: ''
      )

      expect(r.code).to eq('200')
    end


    it "fails with bad inputs" do
      expect {
        r = Fray::Data::Response.new(
          status: '200',
          headers: {},
          body: []
        )
      }.to raise_error(ArgumentError)
    end
  end
end
