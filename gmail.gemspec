$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "gmail/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "gmail"
  s.version       = Gmail::VERSION
  s.authors       = ["Nisanth Chunduru"]
  s.email         = ["nisanth074@gmail.com"]
  s.homepage      = "https://github.com/nisanth074/gmail"
  s.summary       = "Ruby gem for Gmail's API"
  s.description   = "Ruby gem for Gmail's API"

  s.files = Dir["{lib}/**/*", "README.md"]

  s.add_development_dependency "rspec", '~> 3.9'
  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
end
