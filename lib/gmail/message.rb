class Gmail
  # @see https://developers.google.com/gmail/api/reference/rest/v1/users.messages#Message
  class Message < Resource
    class << self
      def retrieve(gmail, message_id, params = {})
        properties = { "id" => message_id }
        new(gmail, properties).retrieve(params)
      end

      def retrieve_in_raw_format(gmail, message_id)
        params = { format: "raw" }
        retrieve(gmail, message_id, params)
      end

      def send_raw(gmail, message_raw, message_properties = {})
        encoded_message_raw = Base64.urlsafe_encode64(message_raw)
        message_properties[:raw] = encoded_message_raw
        _send(gmail, message_properties)
      end

      def _send(gmail, message_properties)
        send_url = "https://www.googleapis.com/gmail/v1/users/me/messages/send"
        response = gmail.post(send_url, message_properties)
        Gmail::Message.new(gmail, response.to_h)
      end
    end

    def initialize(gmail, properties)
      @gmail = gmail
      @properties = properties
    end

    def id
      @properties["id"]
    end

    def url
      "https://www.googleapis.com/gmail/v1/users/me/messages/#{id}"
    end

    def thread_id
      @properties["threadId"]
    end

    def history_id
      @properties["historyId"]
    end

    def retrieve(params = {})
      response = @gmail.get(url, params)
      @properties = JSON.parse(response.body)
      self
    end

    def message_id
      message_id_header_value.sub("<", "").sub(">", "")
    end

    def message_id_header_value
      message_id_header["value"]
    end

    def message_id_header
      headers.detect { |header| header["name"].casecmp?("message-id") }
    end

    def headers
      @properties["payload"]["headers"]
    end

    def raw
      @properties["raw"]
    end

    def decoded_raw
      Base64.urlsafe_decode64(raw)
    end

    def time
      milliseconds_since_epoch = @properties["internalDate"].to_i
      seconds_since_epoch = milliseconds_since_epoch / 1000
      Time.at(seconds_since_epoch)
    end

    def older_than?(time)
      self.time < time
    end

    def label_ids
      Array(@properties["labelIds"])
    end

    def draft?
      label_ids.include?("DRAFT")
    end
  end
end
