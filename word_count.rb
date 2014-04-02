require_relative 'lib/speed_counter'

begin
  url = URI(ARGV[0])
rescue
  url = "http://blog.theknot.com"

end
puts "Scanning url #{url}"

counter = SpeedCounter.new url
counter.run
