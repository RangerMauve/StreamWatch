%w{haml sinatra sequel}.each{|n| require n}
#$DB = Sequel.connect(ENV['DATABASE_URL'])

get '/' do
	"Hello World"
end
