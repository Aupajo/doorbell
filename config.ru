require 'rack/request'
require 'twilio-ruby'

class Response
  STATUS = 200
  HEADERS = { 'Content-Type' => 'text/xml' }

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def to_a
    [STATUS, HEADERS, [body]]
  end

  private

  def body
    puts @request.params.inspect

    Twilio::TwiML::VoiceResponse.new do |response|
      response.say("Please enter the password")
    end.to_s
  end
end

run -> (env) { Response.new(env).to_a }
