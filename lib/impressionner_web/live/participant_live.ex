defmodule ImpressionnerWeb.ParticipantLive do
  use ImpressionnerWeb, :live_view

  alias Impressionner.Contexts.Users
  alias Impressionner.Contexts.Tasks

  def render(assigns) do
    if assigns[:user] do
      ImpressionnerWeb.ParticipantLive.Task.render(assigns)
    else
      ~H"<%= live_component(ImpressionnerWeb.ParticipantLive.LoginForm, id: :login_form) %>"
    end
  end

  def mount(_params, _session, socket) do
    Tasks.subscribe()
    Users.subscribe()
    current_task = Tasks.current()

    socket_with_assigs =
      socket
      |> assign(:current_task, current_task)
      |> assign(:hint_opened, false)

    {:ok, socket_with_assigs}
  end

  def handle_event("ready", _params, socket) do
    if socket.assigns.user do
      user = Users.ready(socket.assigns.user.username)
      {:noreply, assign(socket, :user, user)}
    else
      {:noreply, socket}
    end
  end

  def handle_event("open_hint", _params, socket) do
    if socket.assigns[:user] do
      {:noreply, assign(socket, :hint_opened, true)}
    else
      {:noreply, socket}
    end
  end

  def handle_info({:login, username}, socket) do
    user = Users.load_user(username)
    {:noreply, assign(socket, :user, user)}
  end

  def handle_info(%{topic: "users"}, socket) do
    if socket.assigns[:user] do
      user = Users.load_existing_user(socket.assigns.user.username)

      if is_nil(user) do
        {:noreply, push_navigate(socket, to: "/")}
      else
        {:noreply, assign(socket, :user, user)}
      end
    else
      {:noreply, socket}
    end
  end

  def handle_info(%{topic: "tasks"}, socket) do
    current_task = Tasks.current()

    updated_socket =
      socket
      |> assign(:current_task, current_task)
      |> assign(:hint_opened, false)

    {:noreply, updated_socket}
  end
end
