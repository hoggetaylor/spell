defmodule SpellWeb.Router do
  use SpellWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SpellWeb do
    pipe_through :api
  end
end
