%w{haml sinatra sequel date}.each{|n| require n}

$DB = Sequel.connect(ENV['DATABASE_URL'])
$timeout = 4 #Hourse from last refresh for a stream to be removed

# Create tables for database if not present
$DB.create_table? :streams do
	primary_key :id
	String :name
	DateTime :time
end

class Stream < Sequel::Model
	def timed_out?
		el = (DateTime.now - self[:time].to_datetime)
		el.strftime("%k").to_i < $timeout
	end
end

get '/' do
	haml :home
end

get '/:name' do |name|
	@stream = name
	haml :stream
end

get '/player/:name' do |name|
	@stream = name
	haml :player
end
