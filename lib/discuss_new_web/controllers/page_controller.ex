defmodule DiscussNewWeb.PageController do
  use DiscussNewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
