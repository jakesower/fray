module Fray::Data
  class Response < Dry::Types::Struct
    attribute :success, Types::Bool
    attribute :body, Types::Hash.default({})
  end
end
