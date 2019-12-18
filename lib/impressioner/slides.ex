defmodule Impressioner.Slides do
  use Agent

  @topic "slides"
  @update_message "updated"

  def start_link(_) do
    slides = Impressioner.SlideList.list()
    Agent.start_link(fn -> %{slides: slides, current: nil} end, name: __MODULE__)
  end

  def next() do
    Agent.update(__MODULE__, fn
      %{slides: slides, current: nil} ->
        broadcast_change(Enum.at(slides, 0))
        %{slides: slides, current: 0}

      %{slides: slides, current: index} ->
        next_index = index + 1

        if next_index <= last_index(slides) do
          broadcast_change(Enum.at(slides, next_index))
          %{slides: slides, current: next_index}
        else
          broadcast_change(nil)
          %{slides: slides, current: nil}
        end
    end)
  end

  def prev() do
    Agent.update(__MODULE__, fn
      %{slides: slides, current: nil} ->
        broadcast_change(Enum.at(slides, last_index(slides)))
        %{slides: slides, current: last_index(slides)}

      %{slides: slides, current: index} ->
        prev_index = index - 1

        if prev_index >= first_index(slides) do
          broadcast_change(Enum.at(slides, prev_index))
          %{slides: slides, current: prev_index}
        else
          broadcast_change(nil)
          %{slides: slides, current: nil}
        end
    end)
  end

  def get() do
    Agent.get(__MODULE__, fn
      %{slides: _slides, current: nil} -> nil
      %{slides: slides, current: index} -> Enum.at(slides, index)
    end)
  end

  def subscribe do
    ImpressionerWeb.Endpoint.subscribe(@topic)
  end

  defp broadcast_change(slide) do
    ImpressionerWeb.Endpoint.broadcast(@topic, @update_message, %{slide: slide})
  end

  defp last_index(slides) do
    Enum.count(slides) - 1
  end

  defp first_index(_slides), do: 0
end
