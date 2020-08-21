defmodule DiscussNew.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field(:content, :string)
    belongs_to(:user, DiscussNew.User)
    belongs_to(:topic, DiscussNew.Topic)

    timestamps()
  end

  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
