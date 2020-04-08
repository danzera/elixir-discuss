defmodule Discuss.CommentsChannel do
	use Discuss.Web, :channel

	# join() is called whenever a JavaScript client attempts to join this channel
	# arg #1: the specific route that the user tried to join with
	#					NOTE: the docs refer to this arg as a "topic", not "name" as shown here
	# 						  in this context topic is NOT a topic as defined elsewhere in our application, the naming convention is just a coincidence
	# arg #2: 
	# arg #3: the actual socket object, which represents the entire life-cycle of the socket, just like the conn object in controllers
	def join(name, payload, socket) do
		IO.puts(name)

		{:ok, %{hey: "there"}, socket}
	end

	def handle_in(name, message, socket) do

		# success response
		{:reply, :ok, socket}
	end
end