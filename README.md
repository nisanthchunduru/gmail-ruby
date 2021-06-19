# gmail

Ruby gem for Gmail's API

## Installation

Add the gem to your Rails app's Gemfile

```ruby
gem "gmail", git: "https://github.com/nisanth074/gmail", branch: "main"
```

and bundle install

```bash
bundle install
```

## Usage

```ruby
gmail = Gmail.new(google_oauth_access_token)

# Fetch the 100 most recent messages and print a snippet of the each message
messages = gmail.messages
messages.each { |message| puts message.snippet }

# Fetch the next 100 most recent messages and print a snippet of each message
messages = messages.next_page
messages.each { |message| puts message.snippet }

# Find a message by its RFC 2822 Message-ID
message_id = "0B.41.02024.806BCC06@ap.mta1vrest.cc.prd.sparkpost"
message = gmail.message.find_message_by_message_id(message_id)

# Fetch a message's raw and print it
puts message.retrieve("format" => "raw").raw
```

## Todos

- Port tests from the app
- Modify the `Gmail::Message.raw` method to fetch the message in the `raw` format so gem users don't have to do it themselves
- Add a license
- Publish to rubygems.org
