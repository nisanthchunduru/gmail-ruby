class Gmail
  class ResourceNotFound < StandardError; end

  def initialize(oauth_authorization)
    @oauth_authorization = oauth_authorization
  end

  def profile
    Gmail::Profile.new(self).retrieve
  end

  def history(params = {})
    Gmail::History.new(self).retrieve(params)
  end

  def watch(params)
    Gmail::Watch.create(gmail, params)
  end

  def unwatch
    Gmail::Watch.delete(gmail)
  end

  def messages(params = {})
    messages = MessageCollection.new(self)
    messages.retrieve(params)
  end

  # @todo Add tests
  def messages_received_after(time)
    messages("q" => "after:#{time.to_i}")
  end

  def most_recent_message
    messages("maxResults" => 1).first
  end

  # @todo Add tests
  def find_message_by_message_id(message_id)
    messages = messages("q" => "rfc822msgid:#{message_id}", "includeSpamTrash" => true, "maxResults" => 1)
    message = messages.first
    message.retrieve
    message.message_id == message_id ? message : nil
  end

  def retrieve_message(message_id)
    Gmail::Message.retrieve(self, message_id)
  end

  def retrieve_message_in_raw_format(message_id)
    Gmail::Message.retrieve_in_raw_format(self, message_id)
  end

  def send_raw(message_raw, message_hash = {})
    Gmail::Message.send_raw(self, message_raw, message_hash)
  end

  def message_with_message_id(message_id)
    messages(q: "rfc822msgid:#{message_id}").first
  end

  def thread_id_for_message_with_message_id(message_id)
    message = message_with_message_id(message_id)
    return unless message
    message.thread_id
  end

  def get(url, params = {})
    options = { headers: authorization_headers }
    options[:query] = params unless params.empty?

    Hooligan.get(url, options)
  rescue Hooligan::UnsuccessfulResponse => e
    raise e unless e.response.code == 404
    raise Gmail::ResourceNotFound
  end

  def post(url, body_hash = {})
    options = { headers: authorization_headers }
    unless body_hash.empty?
      body = body_hash.to_json
      options[:body] = body
      options[:headers].merge("Content-Type" => "application/json")
    end

    Hooligan.post(url, options)
  end

  private

  attr_reader :oauth_authorization

  def authorization_headers
    {
      "Authorization" => "Bearer #{access_token}",
      "Content-Type" => "application/json"
    }
  end

  def access_token
    @oauth_authorization.latest_access_token
  end
end
