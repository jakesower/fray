module Fray
  class Filter < Dry::Types::Struct
    attribute :subject, Types::String
    attribute :target, Types::String
  end
end
