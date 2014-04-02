module Logable

  def Logable.set_log_file(url)
    @log_file = "logs/log-#{url.gsub('http://', '')}"
  end

  def Logable.log(message)
    open(@log_file, "a") do |out|
      out << "#{message}\n"

    end
  end
end