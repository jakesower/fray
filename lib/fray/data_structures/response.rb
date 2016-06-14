module Zigzag
  Response = Struct.new(
    # http code
    :code,

    # http headers
    :headers,

    # http body
    :body
  )
end
