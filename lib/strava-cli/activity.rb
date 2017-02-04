module StravaCli
  class Activity
    attr_accessor :type, :duration, :time, :distance

    def to_s
      [type, time, duration, distance].join(", ")
    end

    def name
      type.capitalize
    end

    def save
      response = api.post "/api/v3/activities" do |request|
        request.headers["Authorization"] = "Bearer #{ENV['STRAVA_ACCESS_TOKEN']}"
        request.body = { name: name, type: type, elapsed_time: duration, distance: distance, start_date_local: time }
      end
      puts response.inspect
    end

    private

    def api
      @api ||= Faraday.new(url: "https://www.strava.com")
    end
  end
end