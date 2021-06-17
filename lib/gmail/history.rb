class Gmail
  class History < ResourceCollection
    def name
      "history"
    end

    def url
      "https://www.googleapis.com/gmail/v1/users/me/history"
    end

    def resource_class
      Gmail::HistoryItem
    end
  end
end
