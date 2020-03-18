defmodule Discuss.PageController do
  use Discuss.Web, :controller

	def index(conn, _params) do
		# send user the index.html page
    render conn, "index.html"
  end
end
