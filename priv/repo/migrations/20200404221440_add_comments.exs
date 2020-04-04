defmodule Discuss.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
		# create a new table called "comments"
		create table(:comments) do
			add :content, :string # add a column called "comment" with the data type string
			add :user_id, references(:users) # specifies a reference to the users table, a comment HAS ONE user
			add :topic_id, references(:topics) # specifies a reference to the topics table, a comment HAS ONE topic

			# timestamps function automatically adds an inserted_at and updated_at property to each record in the table
			timestamps() # may not NEED timestamps, but might as well include them in case you want to know when a record was created/updated
		end
  end
end
