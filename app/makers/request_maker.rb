require 'net/http'
require 'uri'
require 'json'
load 'constants/KEY.rb'
load 'constants/QUERY.rb'


class RequestMaker
  def initialize
    uri = URI.parse("https://api.github.com/graphql")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "bearer #{KEY}"
    request.body = JSON.dump({"query" => "#{QUERY}"})
    req_options = {use_ssl: uri.scheme == "https", }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|

      @response= JSON.parse(http.request(request).body)

    end


  end

  attr_accessor :response


end

