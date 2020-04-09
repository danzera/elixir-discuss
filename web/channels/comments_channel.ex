defmodule Discuss.CommentsChannel do
	use Discuss.Web, :channel
	alias Discuss.{Topic, Comment} # identical to 2 separate alias statements referencing Topic and Comment individually

	# join() is called whenever a JavaScript client attempts to join this channel
	# arg #1: the specific route that the user tried to join with, will be of the form "comments:{ID}"
	#					"comments:" <> topic_id as shown in the args list is how we pattern match with a string to parse out the topic_id
	#					NOTE: the docs refer to this arg as a "topic", not "name" as shown here
	# 						  in this context topic is NOT a topic as defined elsewhere in our application, the naming convention is just a coincidence
	# arg #2: 
	# arg #3: the actual socket object, which represents the entire life-cycle of the socket, just like the conn object in controllers
	def join("comments:" <> topic_id, payload, socket) do
		IO.puts("channel joined == comments:" <> topic_id)
		IO.puts("payload")
		IO.inspect(payload)
		IO.puts("socket")
		IO.inspect(socket)
		# topic_id from the arg is a string, need an integer to work with the database
		topic_id = String.to_integer(topic_id)

		topic = Topic # Topic model
			|> Repo.get(topic_id) # ^ gets piped in to Repo.get
			|> Repo.preload(:comments) # load up the comments that are associated with the topic
		
		IO.puts("requested topic and its associated comments")
		IO.inspect(topic)

		# socket object has an "assigns" property (pluarl) on it, just like the conn object
		# can add data to this property via the "assign" function (singular) and this data will be available throughout the channel
		{:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
	end

	def handle_in(name, %{"content" => content} = _message, socket) do
		IO.puts("channel name")
		IO.inspect(name)
		IO.puts("content of message from client")
		IO.inspect(content)

		topic = socket.assigns.topic

		changeset = topic
			|> build_assoc(:comments) # produce a %Comment{} struct with an association to the topic model
			|> Comment.changeset(%{content: content}) # changeset function in comment.ex model module

		# attempt to insert the new comment into our database
		case Repo.insert(changeset) do
			# database insert successful
			{:ok, comment} ->
				{:reply, :ok, socket}
			# database insert failure
			{:error, _reason} ->
				# pass back the changeset for the list of errors
				{:reply, {:error, %{errors: changeset}}, socket}
		end

		# success response
		{:reply, :ok, socket}
	end
end