defmodule Impressionner.Contexts.Tasks do
  alias Impressionner.Storage.Tasks, as: TaskStorage
  alias Impressionner.Contexts.Users

  def all do
    %{ sections: sections } = TaskStorage.get()
    sections
  end

  def current do
    %{ sections: sections, current_task: current_task } = TaskStorage.get()

    if current_task do
      section = Enum.find(sections, &(&1.name == current_task.section))
      Enum.find(section.tasks, &(&1.name == current_task.task))
    else
      nil
    end
  end

  def start do
    %{ sections: sections } = TaskStorage.get()
    first_section = List.first(sections)
    first_task = List.first(first_section.tasks)

    current_task = %{ section: first_section.name, task: first_task.name }
    TaskStorage.set(%{ sections: sections, current_task: current_task })

    Users.reset_all_users()

    broadcast_event("started")
  end

  def next do
    %{ sections: sections, current_task: current_task } = TaskStorage.get()
    current_section_index = Enum.find_index(sections, &(&1.name === current_task.section))
    current_section = Enum.at(sections, current_section_index)
    current_task_index = Enum.find_index(current_section.tasks, &(&1.name === current_task.task))

    cond do
      is_last_section(sections, current_section) && is_last_task_in_section(current_section, current_task_index) ->
        TaskStorage.set(%{ sections: sections, current_task: nil })

      is_last_task_in_section(current_section, current_task_index) ->
        next_section = Enum.at(sections, current_section_index + 1)
        new_current_task = %{ section: next_section.name, task: next_section.tasks[0].name }
        TaskStorage.set(%{ sections: sections, current_task: new_current_task })

      true ->
        next_task_name = Enum.at(current_section.tasks, current_task_index + 1)
        new_current_task = %{ section: current_section.name, task: next_task_name.name }
        TaskStorage.set(%{ sections: sections, current_task: new_current_task })
    end

    Users.reset_all_users()

    broadcast_event("next")
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Impressionner.PubSub, "tasks")
  end

  defp is_last_section(sections, section_index) do
    section_index >= Enum.count(sections) - 1
  end

  defp is_last_task_in_section(section, task_index) do
    task_index >= Enum.count(section.tasks) - 1
  end

  defp broadcast_event(event) do
    Phoenix.PubSub.broadcast(Impressionner.PubSub, "tasks", %{topic: "tasks", event: event})
  end
end
