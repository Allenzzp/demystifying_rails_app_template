class Post
  attr_reader :id, :title, :body, :author, :created_At

  def self.find(id)
    post_hash = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", id).first
    Post.new(post_hash)
  end

  def self.all
    post_hashes = connection.execute("SELECT * FROM posts")
    post_hashes.map do |post_hash|
      Post.new(post_hash)
    end
  end

  def self.connection
    db_connection = SQLite3::Database.new "db/development.sqlite3"
    db_connection.results_as_hash = true
    db_connection
  end

  def initialize(attributes={})
    set_attrtibutes(attributes)
  end

  def set_attrtibutes(attributes)
    @id = attributes["id"] if new_record?
    @title = attributes["title"]
    @body = attributes["body"]
    @author = attributes["author"]
    @created_At ||= attributes["created_At"]
  end

  def new_record?
    id.nil?
  end

  def save
    if new_record?
      insert
    else
      update
    end
  end
  
  def insert
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_At)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query, 
      title,
      body,
      author,
      Date.current.to_s
  end

  def update
    update_query = <<-SQL
      UPDATE posts
      SET title = ?,
          body = ?,
          author = ?
      WHERE posts.id = ?
    SQL

    connection.execute update_query, title, body, author, id
  end

  def destroy
    connection.execute("DELETE FROM posts WHERE posts.id = ?", id)
  end

  #if without .class -> when instance calls connection, will get into the self.connection loop
  #need this because instance can't call class method directly!
  def connection
    puts "hello u called me!"
    self.class.connection
  end
    
end

