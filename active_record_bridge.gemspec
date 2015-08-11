$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_record_bridge/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_record_bridge"
  s.version     = ActiveRecordBridge::VERSION
  s.authors     = ["Nick Blanchet"]
  s.email       = ["h55nick@gmail.com"]
  s.homepage    = "https://github.com/h55nick/ActiveRecordBridge"
  s.summary     = "TODO: Summary of ActiveRecordBridge."
  s.description = "TODO: Description of ActiveRecordBridge."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.2"

  s.add_development_dependency "sqlite3"
end
