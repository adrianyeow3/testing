require 'sqlite3'

$db = SQLite3::Database.new "students.db"

module StudentDB
  def self.setup
    $db.execute(
      <<-SQL
        CREATE TABLE students (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,

          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
        SQL
      )
  end

  def self.seed

    $db.execute(
      <<-SQL
        INSERT INTO students
          (first_name, last_name, created_at, updated_at)
        VALUES
          ('Brick', 'Thornton', DATETIME('now'), DATETIME('now'));

        SQL
      )
  end

  def self.add(first_name, last_name)
  $db.execute(
      <<-SQL
        INSERT INTO students
          (first_name, last_name, created_at, updated_at)
        VALUES
          ("#{first_name}", "#{last_name}", DATETIME('now'), DATETIME('now'));
        SQL
      )
  end

  def self.delete(i)
    $db.execute(
        <<-SQL
          DELETE FROM students WHERE id = "#{i}"
          SQL
        )
  end

  def self.select
    puts "id | first_name | last_name | created_at | updated_at"
    x = $db.execute(
        <<-SQL
          SELECT * FROM students
          SQL
        )
    x.each do |row|
      p row
    end
  end

  def self.show(name)
    x = $db.execute(
        <<-SQL
          SELECT * FROM students WHERE first_name = "#{name}"
          SQL
        )
    x.each do |row|
      p row
    end
  end

   def self.attribute(list)
    x = $db.execute(
        <<-SQL
          SELECT * FROM students WHERE last_name = "#{list}"
          SQL
        )
    x.each do |row|
      p row
    end
   end

   def self.add_column()
    $db.execute(
        <<-SQL
          ALTER TABLE students ADD DateofBirth date
          SQL
        )
   end

   def self.update(id, field, value)
    $db.execute(
      <<-SQL
        UPDATE students
        set "#{field}" = "#{value}"
        WHERE id = "#{id}"
      SQL
      )
   end

   def self.this_month
      x = $db.execute(
      <<-SQL
        SELECT id, first_name, last_name FROM students WHERE strftime('%m',DateofBirth) = strftime('%m','now')
      SQL
      )
      x.each do |row|
        new_row = []
        new_row << row[0]
        row.shift
        new_row << row.join(" ")
        p new_row
      end
   end

   def self.group_by(field)
      x = $db.execute(
        <<-SQL
           SELECT id, first_name,last_name FROM students  ORDER BY "#{field}" ASC;
        SQL
        )
      x.each do |row|
        new_row = []
        new_row << row[0]
        row.shift
        new_row << row.join(" ")
        p new_row

      end
   end
end



#   StudentDB.delete(2)
# StudentDB.attribute("yeow")
StudentDB.update(1, "DateofBirth", '1962-05-20')
StudentDB.update(3, "DateofBirth", '1962-01-19')
StudentDB.update(4, "DateofBirth", '1962-06-20')
StudentDB.update(5, "DateofBirth", '1962-01-13')
StudentDB.update(6, "DateofBirth", '1962-09-20')
StudentDB.update(7, "DateofBirth", '1962-12-20')
# StudentDB.group_by("DateofBirth")

StudentDB.this_month


