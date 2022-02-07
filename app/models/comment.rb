class Comment < BaseModel
  attr_reader :id, :body, :author, :post_id, :created_At, :errors

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

  def post
    Post.find(post_id)
  end


end