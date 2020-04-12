defmodule Discuss.User do
	use Discuss.Web, :model # tell Phoenix this module is a "model"

	# whenever Poison encodes a user, only return the email property
	# wouldn't want any other fields include for security reasons
	@derive {Poison.Encoder, only: [:email]}

	schema "users" do # tell Phoenix what the model looks like in our database
		field :email, :string
		field :provider, :string
		field :token, :string
		has_many :topics, Discuss.Topic # inform Phoenix that an individual user may have many topics, and that the topics model module should be used to setup the relationship
		has_many :comments, Discuss.Comment # inform Phoenix that an individual user may have many comments, and that the comments model module should be used to setup the relationship

		 # timestamps function is called the same way it is in our migration file
		 # informs our schema of the existence of timestamps in the database
		timestamps()
	end

	# how we turn a struct into something that can actually be inserted in the database (how we want to change a record)
	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:email, :provider, :token]) # cast the struct and params to create a changeset, don't need to specifiy timestamps
		|> validate_required([:email, :provider, :token]) # add validation to the changeset, require all fields in this case
	end
end