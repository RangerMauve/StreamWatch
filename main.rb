%w{haml sinatra sequel}.each{|n| require n}
load 'models.rb'

DB = Sequel.connect(ENV['DATABASE_URL'])

# Create tables for database if not present
DB.create_table? :streams do
	primary_key :id
	String :name
	DateTime :time
end

get '/' do
	"Hello World"
end
