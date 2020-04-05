# this module is the socket equivalent to the router file for http requests
defmodule Discuss.UserSocket do
  use Phoenix.Socket

	## Channels
	# general structure of a channel declaration
	# first arg to channel is the name of the channel that the JS client will be attaching to / joining
	# 	":*" is a wild card, much like in the http router => all traffic to the "comments" channel will be funneled to the Discuss.CommentsChannel module
	# second arg is the module that will be in charge of the channel
	# channel "room:*", Discuss.RoomChannel
	channel "comments:*", Discuss.CommentsChannel
  

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(_params, socket) do # called whenever a new JavaScript client connects to our Phoenix server
    {:ok, socket} # socket object is more or less equivalent to the "conn" object in our controllers
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Discuss.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
