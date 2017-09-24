defmodule SpellWeb.AuthController do
  use SpellWeb, :controller
  plug Ueberauth

  def new(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
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
        |> login(user)
        |> render("user.json", user: user)
      {:error, reason} ->
        conn
        |> render("500.json", reason: reason)
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
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
