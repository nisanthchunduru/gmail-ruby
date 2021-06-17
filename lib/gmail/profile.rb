class Gmail
  class Profile < Resource
    def url
      "https://www.googleapis.com/gmail/v1/users/me/profile"
    end

    def history_id
      @properties["historyId"]
    end
  end
end
