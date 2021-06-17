class Gmail
  class HistoryItem
    def initialize(gmail, properties)
      @gmail = gmail
      @properties = properties
    end

    def id
      @properties["id"]
    end

    # @see https://developers.google.com/gmail/api/reference/rest/v1/users.history/list#History
    def messages
      Array(@properties["messages"]).map { |message_hash| Gmail::Message.new(@gmail, message_hash) }
    end

    # @note This property unfortunately hasn't been reliable
    def messages_added
      Array(@properties["messagesAdded"]).map { |message_hash| Gmail::Message.new(@gmail, message_hash) }
    end
  end
end
