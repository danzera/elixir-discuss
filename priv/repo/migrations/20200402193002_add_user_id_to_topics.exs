defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

	def change do
		alter table(:topics) do # syntax for updating a table
			add :user_id, references(:users) # specifies a reference to the users table
		end
  end
end
