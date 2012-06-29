%w{haml sinatra sequel date}.each{|n| require n}

$DB = Sequel.connect(ENV['DATABASE_URL'])
$timeout = 4 #Hourse from last refresh for a stream to be removed

# Create tables for database if not present
$DB.create_table? :streams do
	primary_key :id
	String :name
	DateTime :time
end

$Stream = $DB[:streams];

before do
	@streams = [];
	@streams << "home"
	$Stream.each do |stream|
		@streams << stream[:name].to_s;
	end
end

get '/' do
	haml :home
end

get '/home' do
	redirect '/'
end

get '/:name' do |name|
	@stream = name
	if $Stream[:name => name].nil?
		$Stream.insert(:name => name,:time => DateTime.now);
	else
		$Stream[:name => name].update(:time => DateTime.now);
	end
	haml :stream
end

get '/player/:name' do |name|
	@stream = name
	haml :player
end

get '/chat/:name' do |name|
	@stream = name
	haml :chat
end
