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
      new_user = %User{username: username, state: :not_ready}
      UserStorage.create(new_user)
      broadcast_event("created")
      new_user
    end
  end

  def reset_all_users do
    users = UserStorage.all()

    reset_users = Enum.map(users, &Map.put(&1, :state, :not_ready))
    UserStorage.update_all(reset_users)

    broadcast_event("reset")
  end

  def ready(username) do
    if user = UserStorage.find(username) do
      user = Map.put(user, :state, :ready)
      UserStorage.update(user)
      broadcast_event("user_ready")
      user
    end
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Impressionner.PubSub, "users")
  end

  defp broadcast_event(event) do
    Phoenix.PubSub.broadcast(Impressionner.PubSub, "users", %{topic: "users", event: event})
  end
end
