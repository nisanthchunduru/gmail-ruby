class Gmail
  class Watch
    class << self
      def create(gmail, params)
        watch_url = "https://www.googleapis.com/gmail/v1/users/me/watch"
        gmail.post(watch_url, params)
      end

      def delete(gmail)
        stop_url = "https://www.googleapis.com/gmail/v1/users/me/stop"
        gmail.post(stop_url)
      end
    end
  end
end
