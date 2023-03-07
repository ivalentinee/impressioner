defmodule ImpressionnerWeb.AdminLive do
  use ImpressionnerWeb, :live_view

  alias Impressionner.Contexts.Users
  alias Impressionner.Contexts.Tasks

  def mount(_params, _session, socket) do
    users = Users.all()
    %{ sections: sections, current_task: current_task } = Tasks.all()

    Users.subscribe()
    Tasks.subscribe()

    socket_with_assigs =
      socket
      |> assign(:users, users)
      |> assign(:sections, sections)
      |> assign(:current_task, current_task)

    {:ok, socket_with_assigs}
  end

  def handle_event("start", _params, socket) do
    Impressionner.Contexts.Tasks.start()
    {:noreply, socket}
  end

  def handle_event("next", _params, socket) do
    Impressionner.Contexts.Tasks.next()
    {:noreply, socket}
  end

  def handle_event("delete_user", %{"username" => username}, socket) do
    Impressionner.Contexts.Users.delete(username)
    {:noreply, socket}
  end

  def handle_info(%{topic: "users"}, socket) do
    updated_users = Users.all()
    {:noreply, assign(socket, :users, updated_users)}
  end

  def handle_info(%{topic: "tasks"}, socket) do
    %{ current_task: current_task } = Tasks.all()
    {:noreply, assign(socket, :current_task, current_task)}
  end
end
