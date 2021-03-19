#!/usr/bin/env ruby
require 'nokogiri'

doc = Nokogiri::XML(File.open("./client.xml"))
edges = doc.xpath("//reference/hindrances").first.elements
#edges = doc.css("edges").first.elements

# puts edges.count
# exit

puts 'Name,Major,Type,Benefit'
0.upto(edges.count-1) do |e|
  record = '"' + edges[e].at_css('name').content + '",'
  #puts edges[e].at_css('name').content
  if edges[e].at_css('name').content.include?("Major")
    record = record + 'true,'
  else
    record = record + 'false,'
  end
  record = record + '"' + edges[e].at_css('type').content.gsub(/"/, '\"') + '",'
  record = record + '"'
  print record
  # pull benefit information as html
  benefit = edges[e].elements[0].to_s.encode("UTF-8").gsub(//, '“').gsub(//, '”').gsub(//, '‘').gsub(//, '’')
  benefit = benefit.gsub(//, '–').gsub(//, '—').gsub(//, '•').gsub(//, '…')
  benefit = benefit.gsub(/\n/, '').gsub(/\t/, '') #.gsub(/"/, "”") 
  benefit = benefit.gsub(/<linklist.*linklist>/, '')
  benefit = benefit.gsub(/<\/benefit>/, '')
  benefit = benefit.gsub(/<benefit type="formattedtext">/, '') 
  print benefit
  puts '"'
end
