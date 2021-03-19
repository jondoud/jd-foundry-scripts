#!/usr/bin/env ruby
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection( 
  :adapter  => 'sqlite3', 
  :database => '/Users/jdoud/dev/savageworlds/database/savageworlds.sqlite3'
) 

class Edge < ActiveRecord::Base
end

db_edges = Edge.where("source like '%West%' or source like '%Horror%' or source like '%Pulp%' or source like '%Rippers%' or source like '%Section%' or source like '%Pilot%' or source like '%Deck%'").order(name: :asc)

puts 'Name,Benefit,Source,Requirements'
0.upto(db_edges.count-1) do |e|
  print '"' + db_edges[e].name + '",'
  print '"' + db_edges[e].rule.gsub(/\n/, " ") + '</p><p><b>Source: </b>' + db_edges[e].source + ", page " + db_edges[e].source_page.to_s + '",'
  print '"' + db_edges[e].source + ", page " + db_edges[e].source_page.to_s + '",'
  print '"' + db_edges[e].requirements + '"'
  puts
end
