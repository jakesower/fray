require 'dry-types'

module Types
  include Dry::Types.module
end

require 'fray/version'

require 'fray/lib/response_pipe'
require 'fray/lib/stage_runner'

require 'fray/data_structures/query'
require 'fray/data_structures/response'
