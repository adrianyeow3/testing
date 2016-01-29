require 'sqlite3'

$db = SQLite3::Database.new "address_book.db"

module AddressBook
  def self.setup
    $db.execute_batch(
      "
        CREATE TABLE contacts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          company VARCHAR(100) NOT NULL,
          phone_number VARCHAR(20) NOT NULL,
          email_address VARCHAR(20) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );

        CREATE TABLE groups (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );

        CREATE TABLE contact_groups (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          contact_id INTEGER NOT NULL,
          group_id INTEGER NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL,
          FOREIGN KEY (contact_id) REFERENCES contacts(id),
          FOREIGN KEY (group_id) REFERENCES groups(id)
        );
      "
    )
  end

  def self.seed
    $db.execute_batch(
      "
        INSERT INTO contacts
          (first_name, last_name, company, phone_number, email_address, created_at, updated_at)
        VALUES
          ('Brick', 'Thornton', 'Next Academy', '012-345678', 'nextacademy@gmail.com', DATETIME('now'), DATETIME('now'));
        INSERT INTO groups
          (name, created_at, updated_at)
        VALUES
          ('group', DATETIME('now'), DATETIME('now'));
        INSERT INTO contact_groups
          (contact_id, group_id, created_at, updated_at)
        VALUES
          (1, 1, DATETIME('now'), DATETIME('now'));
        "
      )
  end

  def self.add_contacts(first_name, last_name, company, phone_number, email_address)
  $db.execute(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, company, phone_number, email_address, created_at, updated_at)
        VALUES
          ("#{first_name}", "#{last_name}", "#{company}", "#{phone_number}", "#{email_address}", DATETIME('now'), DATETIME('now'));
        SQL
      )
  end

  def self.add_groups(group)
  $db.execute(
      <<-SQL
        INSERT INTO groups
          (name, created_at, updated_at)
        VALUES
          ("#{group}", DATETIME('now'), DATETIME('now'));
        SQL
      )
  end

  def self.update_contacts(id, field, value)

    if value.match'(\A[\w+\-.]+@[a-z\-]+(\.[a-z\d\-]+)*\.[a-z]+\z)'
       emailaddress = value
       $db.execute(
      <<-SQL
        UPDATE contacts
        set "#{field}" = "#{emailaddress}"
        WHERE id = "#{id}"
      SQL
      )
    else
      puts "try again"
    end
  end

  def self.update_phonenumbers(id, field, value)
    if value.match'(\d{3}-\d{7})'
       phonenumber = value
       $db.execute(
      <<-SQL
        UPDATE contacts
        set "#{field}" = "#{phonenumber}"
        WHERE id = "#{id}"
      SQL
      )
    else
      puts "try again"
    end
  end

  def self.delete_contact(i)
    $db.execute(
        <<-SQL
          DELETE FROM contacts WHERE id = "#{i}"
          SQL
        )
  end

  def self.delete_group(i)
    $db.execute(
        <<-SQL
          DELETE FROM groups WHERE id = "#{i}"
          SQL
        )
  end
end

# AddressBook.setup
# AddressBook.seed
# AddressBook.add_contacts("Adrian", "Yeow", "Next Academy", "01234567", "adrianyeow3@gmail.com")
# AddressBook.add_groups("group 11")
# AddressBook.update_contacts(4, "email_address", "adrianyeow2@gmail.com")
# AddressBook.delete_contact(12)
# AddressBook.update_phonenumbers(2, 'phone_number', '016-2656619')
