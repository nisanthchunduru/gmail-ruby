class Gmail
  class MessageCollection < ResourceCollection
    def url
      "https://www.googleapis.com/gmail/v1/users/me/messages"
    end
  end
end
