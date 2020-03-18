defmodule Discuss.TopicController do
	# code sharing with Phoenix on display here
	# this line directs Phooenix to include code specified in the "controller" function from the web > web.ex file
  use Discuss.Web, :controller

	# conn (connection) is an Elixir struct that is the entire focal point of our Phoenix applciation
	# 	it represents the incoming request to our application AND the outgoing response
	# 	gets passed around from one function to another until the request has been fulfilled its ready to be returned to the user
	# 	contains request origin, request type, request parameters, route info (path), cookies, headers, etc.
	# 	also contains resp_body (response body) - initially nil, resp_cookies, resp_headers, etc.
	# params (parameters) any query params that were included in the URL when the route was hit
	def new(conn, params) do

		# log statements for debugging
		IO.puts "+++++" # denote the start of a new log statement
		IO.inspect conn # "inspect" crawls over a data structure and prints all values in it
		IO.puts "+++++"
		IO.inspect params
		IO.puts "+++++" # denote the end of a log statement

    render conn, "topic.html"
  end
end
