defmodule Discuss.TopicController do
	# code sharing with Phoenix on display here
	# this line directs Phooenix to include code specified in the "controller" function from the web > web.ex file
	use Discuss.Web, :controller
	
	# Discuss.Topic refers to "Topic" struct that Phoenix automatically generates from the "Topic" model
	# aliasing here allows us to refer to "Topic" directly (seen below) as opposed to "Discuss.Topic"
	alias Discuss.Topic

	# conn (connection) is an Elixir struct that is the entire focal point of our Phoenix applciation
	# 	it represents the incoming request to our application AND the outgoing response
	# 	gets passed around from one function to another until the request has been fulfilled its ready to be returned to the user
	# 	contains request origin, request type, request parameters, route info (path), cookies, headers, etc.
	# 	also contains resp_body (response body) - initially nil, resp_cookies, resp_headers, etc.
	# params (parameters) any query params that were included in the URL when the route was hit
	def new(conn, _params) do
		# example of log statements for debugging
		# generally want to remove these once debugging has been completed, just left for reference here
		IO.puts "+++++" # denote the start of a new log statement
		IO.inspect conn # "inspect" crawls over a data structure and prints all values in it
		IO.puts "+++++" # denote the end of a log statement

		# generate and empty (invalid) changeset that will later be merged with the form
		# inputs for our changeset function in our "Topic" module
		# struct = %Topic{} # %Topic{} == %Discuss.Topic{} thanks to the alias statement above
		# params = %{}
		changeset = Topic.changeset(%Topic{}, %{}) # again, %Topic{} == %Discuss.Topic{} thanks to the alias statement above
		
		# Phoenix knows to look for "new.html" in the "templates > topic" directory because of the module name above, "Discuss.TopicController"
    render conn, "new.html", changeset: changeset # any custom data can be included as additional args the way "changeset" is included here
	end
end
