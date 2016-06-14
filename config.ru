require 'rack'
require 'bundler'

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

app = ->(env) do
  ['200', {'Content-Type' => 'text/html'}, [Rack::Utils::parse_nested_query(env['QUERY_STRING']).inspect]]
end

Rack::Handler::WEBrick.run app
