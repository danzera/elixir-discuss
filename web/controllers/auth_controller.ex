defmodule Discuss.AuthController do
	use Discuss.Web, :controller
	plug Ueberauth

	# ueberauth expects us to define a function called "callback"
	def callback(conn, params) do
		IO.puts("----- CONN INFO FROM PROVIDER -----")
		IO.inspect(conn)
		IO.puts("----- PARAMS INFO FROM PROVIDER -----")
		IO.inspect(params)
	end
end