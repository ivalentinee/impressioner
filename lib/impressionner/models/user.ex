defmodule Impressionner.Models.User do
  @enforce_keys [:username, :state]
  defstruct [:username, :state]
end
