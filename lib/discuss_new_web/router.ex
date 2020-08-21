defmodule DiscussNewWeb.Router do
  use DiscussNewWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(DiscussNew.Plugs.SetUser)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussNewWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources("/topics", TopicController)
  end

  scope "/auth", DiscussNewWeb do
    pipe_through(:browser)

    get("/signout", AuthController, :signout)
    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussNewWeb do
  #   pipe_through :api
  # end
end
