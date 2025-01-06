require 'pg'
connection = PG.connect(
    dbname: "Students",
    user: "postgres",
    password: "12345",
    host: "localhost",
    port: 5432
)
connection.exec(File.read('insert.sql'))
result = connection.exec("SELECT * FROM student")
result.each { |row| puts row }
connection.close()