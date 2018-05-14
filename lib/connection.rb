require 'mongo'

class Connection

  def initialize

    # set logger level to FATAL (only show serious errors)
    Mongo::Logger.logger.level = ::Logger::FATAL

    # set up a connection to the mongod instance which is running locally,
    # on the default port 27017
    @client = Mongo::Client.new(
  'mongodb://127.0.0.1:27001,127.0.0.1:27002,127.0.0.1:27003/test?replicaSet=carbon'
 )

  end

  def client
    @client
  end

  # get connections to our two collections
  def incidents
    @client[:incidents]
  end


end
