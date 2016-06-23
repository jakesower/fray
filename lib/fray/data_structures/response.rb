module Fray::Data
  class Response < Dry::Types::Struct
    attribute :code, Types::Coercible::String.enum(
      *((100..102).map(&:to_s) +
        (200..206).map(&:to_s) +
        (300..308).map(&:to_s) +
        (400..417).map(&:to_s) + ['429'] +
        (500..504).map(&:to_s))
    )

    attribute :headers, Types::Hash
    attribute :body, Types::String
  end
end
