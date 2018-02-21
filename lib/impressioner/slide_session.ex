defmodule Impressioner.SlideSession do
  use Agent

  def start_link() do
    Agent.start_link(fn -> nil end, name: __MODULE__)
  end

  def set(slide) do
    Agent.update(__MODULE__, fn _ -> slide end)
  end

  def get() do
    Agent.get(__MODULE__, fn slide -> slide end)
  end
end
