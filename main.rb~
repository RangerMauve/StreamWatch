%w{haml sinatra sequel}.each{|n| require n}
DB = Sequel.connect(ENV['DATABASE_URL'])

# Create tables for database if not present
if DB[:streams].nil? || true then
	create_table :streams do
		
	end
end

get '/' do
	"Hello World"
end
