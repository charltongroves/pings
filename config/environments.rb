#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
configure :production, :development do

	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

	ActiveRecord::Base.establish_connection(
			:adapter => 'postgresql',
			:host     => 'localhost',
			:port	  => '5432',
			:username => 'postgres',
			:password => 'password',
			:database => 'mydb',
			:encoding => 'utf8'
	)
end