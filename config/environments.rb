#Change the values with a "#Change" next to them with your preferred db
configure :production, :development do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
	ActiveRecord::Base.establish_connection(
			:adapter => 'postgresql', #Change
			:host     => 'localhost',
			:port	  => '5432', #Change
			:username => 'postgres', #Change
			:password => 'password', #Change
			:database => 'mydb', #Change
			:encoding => 'utf8'
	)
end