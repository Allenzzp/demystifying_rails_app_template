class ApplicationController < ActionController::Base

  def hello_world
    render plain: "Hello, World!"
    #binding.pry
    #used for inspect respnse
    #response.body/content_type/status
    #another hash
    #render({:plain => 'Hello, World!'})
  end

end
