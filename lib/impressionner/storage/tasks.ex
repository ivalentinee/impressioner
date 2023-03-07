defmodule Impressionner.Storage.Tasks do
  use Agent

  alias Impressionner.Contexts.Tasks.Reader, as: TaskReader

  def start_link(_) do
    Agent.start_link(fn -> %{sections: TaskReader.read(), current_task: nil} end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  def set(tasks) do
    Agent.update(__MODULE__, fn _ -> tasks end)
  end
end
