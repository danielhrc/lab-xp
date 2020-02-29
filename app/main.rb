require 'net/http'
require 'uri'
require 'json'
require 'csv'
require 'time'
load 'KEY.rb'
load 'QUERY.rb'

uri = URI.parse("https://api.github.com/graphql")
request = Net::HTTP::Post.new(uri)
request["Authorization"] = "bearer #{KEY}"
request.body = JSON.dump({"query" => "#{QUERY}"})

req_options = {use_ssl: uri.scheme == "https", }

Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|

  nome="response #{Time.now.utc.to_s.gsub(" "," at ").gsub(":","-").gsub("UTC","").delete_suffix(" at ")}hs"

  response=JSON.parse(http.request(request).body)


  #Save to CSV

  csv_file=File.new("#{nome}.csv","w+")

  CSV.open(csv_file,"wb") do |csv|

    csv<<["nameWithOwner","createdAt"]

    response["data"]["search"]["nodes"].each do |node|

      csv<< [node["nameWithOwner"],node["createdAt"]]

    end

  end

  # Save to JSON
  # File.new(nome<<".json","w+").write(response)


  GC.start
end
