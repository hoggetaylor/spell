defmodule SpellWeb.Authenticator do

  use SpellWeb, :controller

  alias SpellWeb.User
  alias Spell.Repo

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Repo.get(User, user_id)
    assign(conn, :current_user, user)
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> send_resp(401, "Unauthorized")
      |> halt()
    end
  end

end
