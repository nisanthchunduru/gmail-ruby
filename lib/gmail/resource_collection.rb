class Gmail
  class ResourceCollection < Resource
    def name
      resource_name.pluralize
    end

    def resource_name
      resource_class.name.demodulize.downcase
    end

    def resource_class
      self.class.name.sub("Collection", "").constantize
    end

    def to_a
      Array(properties[name]).map do |resource_properties|
        resource_class.new(gmail, resource_properties)
      end
    end

    def first
      to_a.first
    end

    def result_size_estimate
      properties["resultSizeEstimate"]
    end

    def next_page_token
      properties["nextPageToken"]
    end

    def last_page?
      next_page_token.nil?
    end

    def next_page
      params = {
        "pageToken" => next_page_token
      }
      response = gmail.get(url, params)
      response_hash = JSON.parse(response.body)
      self.class.new(gmail, response_hash)
    end
  end
end
