require_relative 'lib/speed_counter'
require 'optparse'

options = OpenStruct.new
options.url = "http://blog.theknot.com"
#options.output_file = 'urls.txt'
# parse command-line options
opts = OptionParser.new
opts.on('-u', '--url url')        { |u| options.url = u }
#opts.on('-o', '--output filename') {|o| options.output_file = o }
opts.parse!(ARGV)


puts "Scanning url #{options.url}"

counter = SpeedCounter.new options.url
counter.run
