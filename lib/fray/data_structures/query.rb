require 'fray/data_structures/filter'

module Fray::Data
  class Query < Dry::Types::Struct
    attribute :search, Types::Coercible::String
    attribute :include, Types::Array
    attribute :filters, Types::Array.member(Fray::Filter)
    attribute :sort, Types::Hash
    attribute :fields, Types::Array.member(Types::String)
    attribute :page, Types::Hash.schema(
      size: Types::Coercible::Int,
      number: Types::Coercible::Int
    )
  end
end
