// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// refactor this file so the ID of the topic a user wants to fetch can be passed in as an argument
const createSocket = (topicId) => {
	// Now that you are connected, you can join channels with a topic:
	let channel = socket.channel(`comments:${topicId}`, {})
	channel.join()
		.receive("ok", resp => { console.log("Joined successfully", resp) })
		.receive("error", resp => { console.log("Unable to join", resp) })
		
	// add an event listener
	document.querySelector('#add-comment').addEventListener('click', () => {
		const content = document.querySelector('#new-comment').value
		console.log(content)
		// channel.push is the function we call whenever we want to send data to our server
		channel.push('comment:add', { content })
	})
}

// export default socket
// instead of exporting the socket, add the create socket to the window scope
// so anywhere inside the application createSocket can be called to join a given channel
// generally not the greatest idea to add things to the window scoped, but...
// in this case we have an HTML template with a JavaScript application embedded inside of it
// so this is a fairly reasonable solution to ensure that the J.S. app only boots up when the template runs
// i.e. the socket is only created when we use the show.html.eex template
window.createSocket = createSocket;
