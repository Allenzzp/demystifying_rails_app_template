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

end
