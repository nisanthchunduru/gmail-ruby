class Gmail
  class Resource
    class << self
      def find(gmail, id)
        new(gmail, "id" => id).retrieve
      end
    end

    attr_reader :gmail,
                :properties

    def initialize(gmail, properties = {})
      @gmail = gmail
      @properties = properties
    end

    def id
      properties["id"]
    end

    def retrieve(params = {})
      response = gmail.get(url, params)
      @properties = JSON.parse(response.body)
      self
    end
  end
end
