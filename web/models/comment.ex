defmodule Discuss.Comment do
	use Discuss.Web, :model

	# tell Poison that only the "content" field should be converted to JSON when transmitting model data to the client
	@derive {Poison.Encoder, only: [:content]}

	schema "comments" do
		field :content, :string
		belongs_to :user, Discuss.User # inform Phoenix that a comment relates to a single user, and that the user model module should be used to setup the relationship
		belongs_to :topic, Discuss.Topic # inform Phoenix that a comment relates to a single topic, and that the topic model module should be used to setup the relationship

		timestamps() # timestamps function is called the same way it is in our migration file
	end

	# how we turn a struct into something that can actually be inserted in the database (how we want to change a record)
	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:content]) # cast the struct and params to create a changeset, don't need to specifiy timestamps
		|> validate_required([:content]) # add validation to the changeset for required fields
	end
end