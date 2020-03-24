defmodule Discuss.TopicController do
	# code sharing with Phoenix on display here
	# this line directs Phooenix to include code specified in the "controller" function from the web > web.ex file
	use Discuss.Web, :controller
	
	# Discuss.Topic refers to "Topic" struct that Phoenix automatically generates from the "Topic" model
	# aliasing here allows us to refer to "Topic" directly (seen below) as opposed to "Discuss.Topic"
	alias Discuss.Topic

	@doc """
	Show a list of all topics.
	"""
	def index(conn, _params) do
		# fetch all topics from the database
		topics = Repo.all(Topic) # equivalent to Discuss.Repo.all(Discuss.Topic), shortened by aliasing Repo via Discuss.Web and Topic above
		# render the index template and make the property "topics" available within the template
		render conn, "index.html", topics: topics
	end

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
	
	# handler for POST /topics route
	# "params" will include the data from our form
	# 	%{"topic" => topic} = params
	def create(conn, %{"topic" => topic}) do
		# generate a new changeset from the topic params that were passed in from the form
		# this represents the changes that we want to make to our database
		# empty struct is used for the first argument because we are creating a new record
		changeset = Topic.changeset(%Topic{}, topic)
	
		# actually insert the record to our database via the Repo module
		# able to reference Repo directly b/c Ecto functionality has been imported/aliased
		# into our controller via Discuss.Web's controller function
		# Repo.insert automatically checks to see if the changeset is valid, does not attempt to insert if it's not valid
		case Repo.insert(changeset) do
			# 2 possible returns from Repo.insert
			{:ok, post} -> # post is what was actually inserted
				conn # conn is the first arg to both put_flash and redirect functions, is piped along into both
				|> put_flash(:info, "Topic Created") # shows msg to user once when the page is reloaded
				|> redirect(to: topic_path(conn, :index)) # keyword list with one entry, sends user to the route using the TopicController index function
			{:error, changeset} ->
				IO.puts("ERROR")
				IO.inspect(changeset)
				# show the user the form again if their input was invalid
				conn
				|> put_flash(:error, "Topic must have a title") # conn is automatically piped in as the first argument
				|> render "new.html", changeset: changeset # conn is automatically piped in as the first argument
				
		end
		# return conn
	end

end
