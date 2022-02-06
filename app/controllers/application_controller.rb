class ApplicationController < ActionController::Base

    # C - create
    # R - read
    # U - update
    # D - delete

  def hello_world
    #render's job: set http response body
    name = params["name"] || "World"
    render 'application/hello_world', locals: {name: name}
    #render inline: File.read('app/views/application/hello_world.html')

    #when erb sees :locals key, will use its value to render template

    #render plain: "Hello, World!"
    #binding.pry
    #used for inspect respnse
    #response.body/content_type/status
    #another hash
    #render({:plain => 'Hello, World!'})
  end

  def list_posts
    posts = connection.execute("SELECT * FROM posts")
    render 'application/list_posts', locals: {
      posts: posts
    }
  end

  def show_post
    post = find_post_by_id(params["id"])
    #execution returns an array
    render 'application/show_post', locals: {
      post: post
    }
  end

  def new_post
    render 'application/new_post'
  end

  def create_post

    #called heredoc syntax <<-SQL ... SQL
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_At)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query, 
      params["title"],
      params["body"],
      params["author"],
      Date.current.to_s
    
    redirect_to '/list_posts'
  end

  def edit_post
    post = find_post_by_id(params["id"])

    render 'application/edit_post', locals: {post: post}
  end

  def update_post
    update_query = <<-SQL
      UPDATE posts
      SET title = ?,
          body = ?,
          author = ?
      WHERE posts.id = ?
    SQL

    connection.execute update_query, params['title'], params['body'], params['author'], params['id']

    redirect_to '/list_posts'
  end

  def delete_post
    connection.execute("DELETE FROM posts WHERE posts.id = ?", params['id'])

    redirect_to '/list_posts'
  end

  private

  def connection
    db_connection = SQLite3::Database.new "db/development.sqlite3"
    db_connection.results_as_hash = true
    db_connection
  end

  def find_post_by_id(id)
    connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", id).first
  end

end
