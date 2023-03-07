defmodule ImpressionnerWeb.ParticipantLive do
  use ImpressionnerWeb, :live_view

  alias Impressionner.Contexts.Users

  def render(assigns) do
    if assigns[:user] do
      ~H"""
      <p><%= @user.username %></p>
      """
    else
      ~H"<%= live_component(@socket, ImpressionnerWeb.ParticipantLive.LoginForm, id: :login_form) %>"
    end
  end

  def mount(_params, session, socket) do
    if session["username"] && is_binary(session["username"]) do
      {:ok, assign(socket, :username, session["username"])}
    else
      {:ok, socket}
    end
  end

  def handle_info({:login, username}, socket) do
    user = Users.load_user(username)
    {:noreply, assign(socket, :user, user)}
  end
end
