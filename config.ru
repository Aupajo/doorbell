require 'rack/request'

class Response
  STATUS = 200
  HEADERS = {}

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def body
    puts @request.params.inspect
    "TBC"
  end

  def to_a
    [STATUS, HEADERS, [body]]
  end
end

run -> (env) { Response.new(env).to_a }
