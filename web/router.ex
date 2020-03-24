defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

		# ROUTES
		 # breaking RESTful convention here to show all topics at the base route
		 # would generally use the route: get "/topics", TopicController, :index
		get "/", TopicController, :index
		get "/topics/new", TopicController, :new
		post "/topics", TopicController, :create
		get "/topics/:id/edit", TopicController, :edit # use router wildcard to catch the topic ID, params object will have id property on it as a result
		put "/topics/:id", TopicController, :update
	end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
