defmodule Impressionner.Contexts.Users do
  alias Impressionner.Models.User
  alias Impressionner.Storage.Users, as: UserStorage

  def all do
    UserStorage.all()
  end

  def load_user(username) when is_binary(username) do
    if existing_user = UserStorage.find(username) do
      existing_user
    else
      Phoenix.PubSub.broadcast(Impressionner.PubSub, "users", %{topic: "users", event: "created"})
      UserStorage.create(%User{username: username})
    end
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Impressionner.PubSub, "users")
  end
end
