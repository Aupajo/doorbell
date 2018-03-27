require 'rack/request'
require 'twilio-ruby'

PASSCODE = ENV.fetch("PASSCODE").to_i.to_s
UNLOCK_DOOR_DIGIT = 1
TIMEOUT_IN_SECS = ENV.fetch("TIMEOUT_IN_SECS", "10").to_i

class Response
  STATUS = 200
  HEADERS = { 'Content-Type' => 'text/xml' }

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def body
    log_request

    if given_passcode
      verify_passcode
    else
      prompt_for_password
    end
  end

  def to_a
    [STATUS, HEADERS, [body]]
  end

  private

  def log_request
    puts @request.params
  end

  def prompt_for_password
    twiml do |response|
      response.say "Please enter the #{PASSCODE.length} digit passcode"
      response.gather(numDigits: PASSCODE.length, timeout: TIMEOUT_IN_SECS)
      response.say "Goodbye"
    end
  end

  def verify_passcode
    twiml do |response|
      if given_passcode == PASSCODE
        response.say "Granting access"
        response.play(digits: UNLOCK_DOOR_DIGIT)
      else
        response.say "I'm sorry. That's the wrong passcode"
      end
    end
  end

  def given_passcode
    @request.params['Digits']
  end

  def twiml(&block)
    Twilio::TwiML::VoiceResponse.new(&block).to_s
  end
end

run -> (env) { Response.new(env).to_a }
