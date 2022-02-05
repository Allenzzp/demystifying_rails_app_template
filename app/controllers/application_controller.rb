class ApplicationController < ActionController::Base

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
    post = connection.execute("SELECT * FROM posts WHERE posts.id = ?", params["id"]).first
    #execution returns an array
    render 'application/show_post', locals: {
      post: post
    }
  end

  private

  def connection
    db_connection = SQLite3::Database.new "db/development.sqlite3"
    db_connection.results_as_hash = true
    db_connection
  end

end
