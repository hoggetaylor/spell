defmodule SpellWeb.User do
  use SpellWeb, :model

  @derive {Poison.Encoder, only: [
    :first_name, 
    :last_name, 
    :email
  ]}
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, ~w(first_name last_name email provider token), [])
  end
end
