defmodule Discuss.Topic do
	# code sharing from the model function in web > web.ex
	# ** automatically generates a Topic struct from this module for us **
	use Discuss.Web, :model

	# describe "topics" table schema for Phoenix
	schema "topics" do
		# the topics table has one field called "title" of data type string
		field :title, :string
		belongs_to :user, Discuss.User # inform Phoenix that a topic relates to a single user, and that the user model module should be used to setup the relationship
		has_many :comments, Discuss.Comment # inform Phoenix that an individual topic may have many comments, and that the comments model module should be used to setup the relationship
	end

	# produce a changeset to record new/updated data in the database
	# struct is the existing database record (if any)
	# params is the updated (or new) record
	# generally these will both have the same properties
	# \\ %{} specifies the default argument for 'params' should nil be passed in
	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:title]) # describe how to get from the struct to the params (what's changing in the DB)
		|> validate_required([:title]) # perform data validation on the specified properties - what's required to have a value
	end
end