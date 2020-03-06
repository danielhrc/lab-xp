require 'csv'
load 'constants/NAME_MAKER.rb'
load 'makers/request_maker.rb'

class CsvMaker

  def initialize
    @response=RequestMaker.new.response

    CSV.open( File.new("#{FILENAME}.csv","w+"),"wb") do |csv|

      csv<<["nameWithOwner","createdAt"]

      @response["data"]["search"]["nodes"].each do |node|

        csv<< [node["nameWithOwner"],node["createdAt"]]

      end

    end

  end

end