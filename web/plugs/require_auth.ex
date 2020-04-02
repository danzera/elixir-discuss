defmodule Discuss.Plug.RequireAuth do
	import Plug.Conn # gives us access to the halt() function used below
	import Phoenix.Controller # give us access to put_flash and redirect functions
	
	alias Discuss.Router.Helpers # allows us to shorten our reference to Helpers.topic_path below

	# run once for the lifetime of the application
	def init(_params) do
		# required to define this function, but again don't want to do anything in this case
	end

	# run every time the plug is called
	def call(conn, _params) do # _params would be the return from the init function
		# check if the user is logged in
		# would be challenging to pattern match with a case statement here, b/c we can't be sure what conn.assigns[:user] contains
		# could potentially use a cond statement, but if statement is easier
		if conn.assigns[:user] do
			conn # let them pass, just return the connection
		else # show and error/redirect
			conn
			|> put_flash(:error, "Please login")
			|> redirect(to: Helpers.topic_path(conn, :index))
			|> halt() # use this function in a plug to tell phoenix to send the conn back to the user without moving on to the next plug/controller
		end
	end
end