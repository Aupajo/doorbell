require 'rack/request'

run lambda do |env|
  request = Rack::Request.new(env)

  puts request.params.inspect

  [200, {}, ["OK"]]
end
