require 'net/http'
require 'uri'
require 'json'
load 'KEY.rb'

uri = URI.parse("https://api.github.com/graphql")
request = Net::HTTP::Post.new(uri)
request["Authorization"] = "bearer #{KEY}"
request.body = JSON.dump({
                             "query" => "query { viewer { login }}"
                         })

req_options = {
    use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|

  filename="response #{Time.now.utc.to_s
                           .gsub(" "," at ")
                           .gsub(":","-")
                           .gsub("UTC","")
                           .delete_suffix(" at ")}hs.json"
  file=File.new(filename,"w+")
  file.write(http.request(request).body)
  file.close
end
