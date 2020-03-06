load 'makers/request_maker.rb'
load 'makers/csv_maker.rb'

CsvMaker.new(RequestMaker.new.response)