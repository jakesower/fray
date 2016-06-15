module Fray
  class Response < Dry::Types::Struct
    attribute :code, Types::Coercible::String.enum(
      *((100..102).map(&:to_s) +
        (200..206).map(&:to_s) +
        (300..308).map(&:to_s) +
        (400..417).map(&:to_s) + ['429'] +
        (500..504).map(&:to_s))
    )

    attribute :headers, Types::Hash.default({})
    attribute :body, Types::String.default('')
  end
end

# module Fray
#   Response = Types::Hash.schema(
#     code: Types::Coercible::String.enum(
#       *((100..102).map(&:to_s) +
#         (200..206).map(&:to_s) +
#         (300..308).map(&:to_s) +
#         (400..417).map(&:to_s) + ['429'] +
#         (500..504).map(&:to_s))
#     ),

#     headers: Types::Hash.default({}),
#     body: Types::String.default('')
#   )
# end
