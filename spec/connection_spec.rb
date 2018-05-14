require 'mongo'
require 'connection'

describe Connection do

  conn = Connection.new

  describe ".initialize" do
    it "establishes a valid connection" do
      expect(conn.client.database).to be_a(Mongo::Database)
    end

    it "can connect to the restaurants collection" do
      expect(conn.incidents).to be_a(Mongo::Collection)
    end

  end
end
