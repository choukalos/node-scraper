#!/usr/bin/ruby
require 'rubygems'
require 'json'

# Global Variables
BATCHSIZE = 10
CURLLOC   = "http://localhost:3000/detect/batch/magentomode/"
CURLHEAD  = '-H "Content-Type: application/json"' 

# Function
if ARGV.count < 1
  puts "Syntax:  check_mode.rb FILENAME "
  puts "  where FILENAME has 1 hostname per file "
  exit
end

filename  = ARGV.shift
hostnames = IO.readlines(filename).collect {|host| host.chomp! }
numhosts  = hostnames.size
iterations= numhosts / BATCHSIZE

(0..iterations).each do |i|
  start = i*BATCHSIZE
  stop  = i*BATCHSIZE + (BATCHSIZE-1)
  dohosts = hostnames[start..stop]
  #puts "processing #{i} - #{start} to #{stop}"
  payload = '-d {"hostnames": ' + dohosts.to_s + '}'
  curlcmd = "curl -s #{CURLHEAD} \'#{payload}\' #{CURLLOC}"
  #puts "CMD:  #{curlcmd}"
  rc   = `#{curlcmd}`
  # Catch exceptions if JSON parse fails
  begin
    data = JSON.parse(rc)
    data.each do |x|
      puts "#{x["hostname"]},#{x["mode"]}"
    end
  rescue => err
    dohosts.each do |x|
      puts "#{x},"
    end
  end
  
end






