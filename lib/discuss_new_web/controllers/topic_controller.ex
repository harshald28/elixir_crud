defmodule DiscussNewWeb.TopicController do
  use DiscussNewWeb, :controller

  alias DiscussNew.Topic
  alias DiscussNew.Repo
  alias DiscussNewWeb.Router.Helpers

  plug(DiscussNew.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete])
  plug(:check_topic_owner when action in [:update, :edit, :delete])

  def index(conn, _params) do
    IO.puts("+++")
    IO.inspect(conn.assigns)
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    render(conn, "show.html", topic: topic)
  end

  def create(conn, params) do
    %{"topic" => topic} = params

    # changeset = Topic.changeset(%Topic{}, topic)

    changeset =
      conn.assigns.user
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Helpers.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic, %{})

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, params) do
    %{"id" => topic_id, "topic" => topic} = params
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Helpers.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, params) do
    %{"id" => topic_id} = params
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic, %{})

    case Repo.delete(changeset) do
      {:ok, _status} ->
        conn
        |> put_flash(:info, "Topic deleted successfully")
        |> redirect(to: Helpers.topic_path(conn, :index))

      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Failed to delete topic")
    end
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end
end
