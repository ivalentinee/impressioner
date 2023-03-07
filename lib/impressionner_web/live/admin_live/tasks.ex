defmodule ImpressionnerWeb.AdminLive.Tasks do
  use ImpressionnerWeb, :live_component

  def is_current_section(section, current_task) do
    current_task != nil && section.name == current_task.section
  end

  def is_current_task(section, task, current_task) do
    is_current_section(section, current_task) && task.name == current_task.task
  end
end
