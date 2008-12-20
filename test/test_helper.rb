require 'test/unit'
require 'rubygems'
require 'activesupport'
require 'active_record'
require 'active_record/fixtures'

RAILS_ENV = 'test'

#Setup Rails' magic autoloading
#Post 2.1 Dependencies should be replaced with ActiveSupport::Dependencies
if Object.const_defined? :Dependencies
  Dependencies.load_paths << File.expand_path(File.dirname(__FILE__) + "/../lib/")
else
  ActiveSupport::Dependencies.load_paths << File.expand_path(File.dirname(__FILE__) + "/../lib/")
end

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib/"))

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures/"
$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)


#Setup activerecord
config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))

RAILS_DEFAULT_LOGGER = ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")

#Have fun here if you want to run the plugin against multiple databases
ActiveRecord::Base.configurations = {'test' => config['sqlite']}
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])

#This creates the test database
load(File.dirname(__FILE__) + "/schema.rb")

#initialize the plugin
require File.dirname(__FILE__) + '/../init'

class Test::Unit::TestCase
  fixtures :all

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end
