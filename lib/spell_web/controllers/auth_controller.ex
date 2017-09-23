defmodule SpellWeb.AuthController do
  use SpellWeb, :controller
  plug Ueberauth

  alias SpellWeb.User
  alias Spell.Repo

  def new(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.puts inspect(auth)
    user_params = %{
      token: auth.credentials.token,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      provider: "google"
    }
    changeset = User.changeset(%User{}, user_params)

    create(conn, changeset)
  end

  def create(conn, changeset) do
    case insert_or_update(changeset) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
      {:error, reason} ->
        conn
        |> render("500.json", reason: reason)
    end
  end

  def insert_or_update(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end
