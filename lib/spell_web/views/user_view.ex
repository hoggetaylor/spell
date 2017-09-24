defmodule SpellWeb.UserView do
  use SpellWeb, :view

  def render("user.json", %{user: user}) do
    user
  end
end
