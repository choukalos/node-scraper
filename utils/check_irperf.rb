#!/usr/bin/ruby
require 'rubygems'
require 'json'

# Global Variables
BATCHSIZE     = 5
CURLHEAD      = '-H "Content-Type: application/json"' 
CURLLOC       = "http://localhost:3000/detect/batch/url"


# Function
if ARGV.count < 1
  puts "Syntax:  check_irperf.rb FILENAME "
  puts "  where FILENAME has 1 hostname per file "
  exit
end

filename  = ARGV.shift
hostnames = IO.readlines(filename).collect {|host| host.chomp! }
numhosts  = hostnames.size
iterations= numhosts / BATCHSIZE

puts "hostname,country,status,platform,page_load(ms)"
(0..iterations).each do |i|
  start = i*BATCHSIZE
  stop  = i*BATCHSIZE + (BATCHSIZE-1)
  dohosts = hostnames[start..stop]
  # Call Wappalyzer and Fetch Data
  payload = '-d {"urls": ' + dohosts.to_s + '}'
  curlcmd = "curl -s #{CURLHEAD} \'#{payload}\' #{CURLLOC}"
  rc   = `#{curlcmd}`
  # Process and catch exceptions if JSON parse fails - WAP
  begin
    data = JSON.parse(rc, :quirks_mode => true)
    data.each do |x|
      apps = x["applications"]
      # Search for and Find categories = Ecommerce and print the name for platform
      if apps != nil 
        platform = nil
        apps.each do |y|
          if y["categories"][0] == "Ecommerce" 
            platform = y["name"]
            break
          end
        end
        # put out the CSV
        puts "#{x["hostname"]},#{x["country"]},#{x["status"]},#{platform},#{x["page_load"]}"
      else
        puts "#{x["hostname"]},#{x["country"]},#{x["status"]},,#{x["page_load"]}"
      end
    end
  rescue => err
    puts rc
    data = dohosts
    data.each do |x|
      puts "#{x},,,,"
    end
  end
  
end






