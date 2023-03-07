defmodule Impressionner.Storage.Users do
  use GenServer

  alias Impressionner.Models.User

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  @impl true
  def init(_) do
    table = :ets.new(__MODULE__, [:ordered_set, :public, :named_table])
    {:ok, table}
  end

  def all do
    Enum.reverse(Enum.map(:ets.tab2list(__MODULE__), &from_ets/1))
  end

  def create(user = %User{}) do
    if :ets.insert_new(__MODULE__, to_ets(user)) do
      user
    else
      nil
    end
  end

  def update_all(users) do
    :ets.insert(__MODULE__, Enum.map(users, &to_ets/1))
  end

  def update(user = %User{}) do
    if :ets.insert(__MODULE__, to_ets(user)) do
      user
    else
      nil
    end
  end

  def delete(username) do
    :ets.delete(__MODULE__, username)
  end

  def find(username) do
    case :ets.lookup(__MODULE__, username) do
      [user] -> from_ets(user)
      [] -> nil
    end
  end

  defp from_ets({username, state}) do
    %User{
      username: username,
      state: state
    }
  end

  defp to_ets(user = %User{}) do
    {user.username, user.state}
  end
end
