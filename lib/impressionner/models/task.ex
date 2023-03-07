defmodule Impressionner.Models.Task do
  @enforce_keys [:name, :section, :title, :text]
  defstruct [:name, :section, :title, :text, :hint]
end
