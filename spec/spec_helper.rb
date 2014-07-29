require 'pry'
require 'djin'

def fixture_path(path)
  File.expand_path(File.dirname(__FILE__) + "/fixtures/#{path}")
end
