defmodule Impressioner.SlideList do
  @slides_fs_path "priv/static/slides"
  @slides_base_url "/slides"
  @file_name_regex ~r/\.(png|jpg|jpeg|gif)$/

  def list do
    with {:ok, file_list} <- File.ls(slides_full_path()) do
      file_list
      |> Enum.filter(&matches_file_name_regex?/1)
      |> Enum.sort()
      |> Enum.map(&slide_url/1)
    else
      _ -> []
    end
  end

  def matches_file_name_regex?(file_name) do
    Regex.match?(@file_name_regex, file_name)
  end

  def slide_url(file_name) do
    "#{@slides_base_url}/#{file_name}"
  end

  def slides_full_path do
    Application.app_dir(:impressioner) |> Path.join(@slides_fs_path)
  end
end
