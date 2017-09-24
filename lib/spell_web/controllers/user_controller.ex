defmodule SpellWeb.UserController do
  use SpellWeb, :controller

  def index(conn, _opts) do
    render conn, "user.json", user: conn.assigns.current_user
  end

  def show(conn, %{"id" => id}) do
    render conn, "user.json", user: Repo.get(User, id)
  end
end
