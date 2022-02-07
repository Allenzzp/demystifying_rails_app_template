class Comment
  attr_reader :id, :body, :author, :post_id, :created_At, :errors

  def self.find(id)
    comment_hash = connection.execute("SELECT * FROM comments WHERE comments.id = ? LIMIT 1", id).first
    Comment.new(comment_hash)
  end

  def self.all
    comment_row_hashes = connection.execute("SELECT * FROM comments")
    comment_row_hashes.map do |comment_row_hash|
      Comment.new(comment_row_hash)
    end
  end

  def initialize(attributes = {})
    @id = attributes["id"] if new_record?
    @body = attributes["body"]
    @author = attributes["author"]
    @post_id = attributes["post_id"]
    @created_At ||= attributes["created_At"]
    @errors = {}
  end

  def valid?
    @errors["body"] = "can't be blank" if body.blank?
    @errors["author"] = "can't be blank" if author.blank?
    @errors.empty?
  end

  def new_record?
    @id.nil?
  end

  def save
    return false unless valid?

    if new_record?
      insert
    else
      update
    end

    true
  end

  def insert
    insert_comment_query = <<-SQL
      INSERT INTO comments (body, author, post_id, created_At)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_comment_query,
    @body,
    @author,
    @post_id,
    Date.current.to_s
  end

  def destroy
    connection.execute "DELETE FROM comments WHERE id = ?", id
  end

  def post
    Post.find(post_id)
  end

  def self.connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end


end