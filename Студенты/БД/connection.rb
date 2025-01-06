require 'pg'

class Connection
  DB_PARAMS = {
    dbname: 'Students',
    user: 'postgres',
    password: '12345',
    host: 'localhost',
    port: 5432
  }

  def initialize
    @conn = PG.connect(DB_PARAMS)
  end

  def exec(query)
    @conn.exec(query)
  end

  def close
    @conn.close
  end
end
