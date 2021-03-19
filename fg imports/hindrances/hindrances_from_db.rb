#!/usr/bin/env ruby
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection( 
  :adapter  => 'sqlite3', 
  :database => '/Users/jdoud/dev/savageworlds/database/savageworlds.sqlite3'
) 

class Hindrance < ActiveRecord::Base
end

db_hindrances = Hindrance.where("source like '%West%' or source like '%Horror%' or source like '%Pulp%' or source like '%Rippers%' or source like '%Section%'").order(name: :asc)

puts 'Name,Benefit,Source,Major'
0.upto(db_hindrances.count-1) do |h|
  print '"' + db_hindrances[h].name + '",'
  print '"' + db_hindrances[h].rule.gsub(/\n/, " ") + '</p><p><b>Source: </b>' + db_hindrances[h].source + ", page " + db_hindrances[h].source_page.to_s + '",'
  print '"' + db_hindrances[h].source + ", page " + db_hindrances[h].source_page.to_s + '",'
  if(db_hindrances[h].category == "Minor")
    print 'false'
  else
    print 'true'
  end
  puts
end
