require 'net/http'
require 'uri'
require 'json'
require 'csv'
load 'constants/KEY.rb'
load 'constants/QUERY.rb'
load 'constants/NAME_MAKER.rb'



class RequestMaker
  def initialize


    uri = URI.parse("https://api.github.com/graphql")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "bearer #{KEY}"
    request.body = JSON.dump({"query" => "#{QUERY}"})
    req_options = {use_ssl: uri.scheme == "https", }



    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|


      CSV.open( File.new("#{FILENAME}.csv","w+"),"wb") do |csv|

        @response= JSON.parse(http.request(request).body)

        csv << ["nome", "url","Data de criação", "Total de pullRequests Aceitas", "Data de Atualizacao", "Total de releases", "Total de issues abertas", "Total de issues fechadas","Linguagem Primária"]

        response_navigator(csv)

        count=1
        # Pagination
        while count<1000

          puts "Página #{count}"

              request.body = JSON.dump({"query" => "#{QUERY.gsub("){",", after: \"#{@response["data"]["search"]["pageInfo"]["endCursor"]}\"){")}"})

          endCursor=@response["data"]["search"]["pageInfo"]["endCursor"]

              @response= JSON.parse(http.request(request).body)
            sleep(1)
              response_navigator(csv)


              QUERY.gsub(", after: \"#{endCursor}\"", "")
              count=count+1

        end

      end

    end



  end

  def response_navigator (csv)
    @response["data"]["search"]["nodes"].each do |node|
     csv << [node["nameWithOwner"], node['url'],node['createdAt'], node['pullRequests']['totalCount'], node['updatedAt'], node['releases']['totalCount'], node['opened_issues']['totalCount'], node['closed_issues']['totalCount'], node['primaryLanguage']['name']]
    end
  end

  def response
    @response
  end

end

