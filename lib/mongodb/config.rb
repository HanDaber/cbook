# Yaml config file for db info
@config = YAML.load_file("lib/mongodb/config.yml")
  
@environment = @config["environment"]

@db_host = @config[@environment]["host"]
@db_port = @config[@environment]["port"]
@db_name = @config[@environment]["database"]
@db_log = @config[@environment]["logfile"]

# Configure the environment
if ENV['MONGOHQ_URL']
    # Assuming HEROKU
    DB_ENV = nil
    MongoMapper.config = {DB_ENV => {'uri' => ENV['MONGOHQ_URL']}}
    MongoMapper.database = @db_name
    MongoMapper.connect(DB_ENV)
else
    # Logger code: https://github.com/jnunemaker/mongomapper/blob/master/test/test_helper.rb

    MongoMapper.connection = Mongo::Connection.new(@db_host, @db_port)
    MongoMapper.database = @db_name

    MongoMapper.connection.connect
end