%w{haml sinatra sequel date}.each{|n| require n}

$DB = Sequel.connect(ENV['DATABASE_URL'])
$timeout = 4 #Hourse from last refresh for a stream to be removed
$devkey = "CQc9wE0-VpMb1uY__rDzgR-UVdAQSlAq0M8xXj5boijm_isG2Oll7MKtA6jAixPErknsgkf2EQCw6RlOkQxf15iRThcm2PMU3DtzTE_Mv3YQlZdCFLGQ0AE52DOmlE5_a"

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
end

get '/player/:name' do |name|
	@stream = name
end

before do
	Stream.each do |stream|
		stream.delete if stream.timed_out?
	end
end
