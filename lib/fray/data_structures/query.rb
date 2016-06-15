require 'fray/data_structures/filter'

module Fray
  class Query < Dry::Types::Struct
    attribute :search, Types::Maybe::Coercible::String.default('')
    attribute :include, Types::Maybe::Strict::Array
    attribute :filters, Types::Array.member(Fray::Filter)
    attribute :sort, Types::Maybe::Coercible::Hash
    attribute :fields, Types::Array.member(Types::String)
    attribute :page, Types::Hash.schema(
      size: Types::Coercible::Int,
      number: Types::Coercible::Int
    ).default({size: 10, number: 1})
  end
end
