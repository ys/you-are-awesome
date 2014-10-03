require "json"
require "twilio-ruby"
class Awesome < Sinatra::Base

  get "/" do
    erb :index
  end

  post "/" do
    # To find these visit https://www.twilio.com/user/account
    account_sid = ENV["ACCOUNT_SID"]
    auth_token = ENV["ACCOUNT_AUTH_TOKEN"]

    @client = Twilio::REST::Client.new account_sid, auth_token
    @call = @client.account.calls.create({:to => params[:to],
                                  :from => ENV["ACCOUNT_PHONE_NUMBER"],
                                  :url => "http://you-are-awesome.herokuapp.com/#{params[:name]}.xml"})

    erb :index
  end

  get "/:name.xml" do
    content_type 'application/xml'
    "<?xml version='1.0' encoding='UTF-8'?>
      <Response>
        <Say voice='woman'>You are awesome, #{params[:name]}.</Say>
      <Record maxLength='20' />
    </Response>"
  end
end
