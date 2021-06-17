class Gmail
  class PushNotification
    def initialize(gmail, properties)
      @gmail = gmail
      @properties = properties
    end

    def email
      message.data["emailAddress"]
    end

    def history_id
      message.data["historyId"]
    end

    def message
      @message ||= GCloud::PubSubMessage.new(nil, @properties["message"])
    end
  end
end
