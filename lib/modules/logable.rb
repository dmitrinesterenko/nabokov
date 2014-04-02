module Logable

  def Logable.set_log_file(url)
    log_name  = url.to_s.gsub('http://', '').split('/')[0]
    @log_file = "logs/log-#{log_name}"
  end

  def Logable.log(message)
    open(@log_file, "a") do |out|
      out << "#{message}\n"

    end
  end
end