require 'pg'

class Connection
  DB_PARAMS = {
    dbname: 'Students',
    user: 'postgres',
    password: '12345',
    host: 'localhost',
    port: 5432
  }.freeze

  def initialize
    @conn = PG.connect(DB_PARAMS)
  end

  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def exec(query)
    @conn.exec(query)
  end

  def close
    @conn.close
  end

end
