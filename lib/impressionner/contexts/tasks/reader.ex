defmodule Impressionner.Contexts.Tasks.Reader do
  alias Impressionner.Models.Task
  alias Impressionner.Models.TaskSection

  def read do
    filenames = task_filenames()
    plain_tasks = read_tasks_from_files(filenames)
    group_by_section(plain_tasks)
  end

  defp task_filenames do
    path = Application.get_env(:impressionner, :tasks_folder)
    full_path = Path.join(File.cwd!(), path)

    "#{full_path}/**/*.yaml"
    |> Path.wildcard()
    |> Enum.sort()
  end

  defp read_tasks_from_files(filenames) do
    Enum.map(filenames, fn filename ->
      {:ok, document} = YamlElixir.read_from_file(filename)
      document_to_task(document, filename)
    end)
  end

  defp document_to_task(document, filename) do
    [name, section] = name_and_section(filename)

    %Task{
      name: name,
      section: section,
      title: document["title"],
      description: document["description"],
      text: document["text"],
      hint: document["hint"],
      result: document["result"]
    }
  end

  defp group_by_section(tasks) do
    section_names =
      tasks
      |> Enum.map(& &1.section)
      |> Enum.uniq()
      |> Enum.sort()

    Enum.map(section_names, fn section_name ->
      section_tasks = Enum.filter(tasks, &(&1.section === section_name))
      %TaskSection{name: section_name, tasks: section_tasks}
    end)
  end

  defp name_and_section(filename) do
    path_sections =
      filename
      |> Path.rootname()
      |> Path.split()

    [name, section | _] = Enum.reverse(path_sections)
    [name, section]
  end
end
