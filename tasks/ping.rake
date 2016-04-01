require "net/http"
require "uri"

namespace :app do
  task :ping do
    app_url = ENV['APP_URL']
    time_zone_offset = ENV['TIME_ZONE_OFFSET']
    current_hour = Time.now.getlocal(time_zone_offset).hour
    p "Pinging #{app_url}"
    unless current_hour.between? 1, 7
      uri = URI.parse(app_url)
      http = Net::HTTP.new(uri.host, uri.port)
      if app_url.start_with? 'https'
        http.use_ssl = true
      end
      request = Net::HTTP::Get.new(uri.request_uri)
      http.request(request)
    end
  end
end
