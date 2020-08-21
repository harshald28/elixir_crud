defmodule DiscussNew.Repo do
  use Ecto.Repo,
    otp_app: :discuss_new,
    adapter: Ecto.Adapters.Postgres
end
