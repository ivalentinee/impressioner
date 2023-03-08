defmodule Impressionner.Models.Task do
  @enforce_keys [:name, :section, :title, :description, :text]
  defstruct [:name, :section, :title, :description, :text, :hint, :result]
end
