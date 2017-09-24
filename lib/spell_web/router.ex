defmodule SpellWeb.Router do
  use SpellWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug SpellWeb.Authenticator
  end

  scope "/api", SpellWeb do
    pipe_through [:api, :authenticate_user]

    resources "/user", UserController, only: [:index, :show]
  end

  scope "/auth", SpellWeb do
    pipe_through :api

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :new
  end
end
