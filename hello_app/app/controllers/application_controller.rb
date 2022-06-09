class ApplicationController < ActionController::Base
  def hello
    render html: "HELLO WORLD 👋"
  end
end
