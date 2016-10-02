defmodule HashPipe.Parse do

  def file(path, indent) do
    path
    |> File.stream!
    |> Stream.map(&hashpipe/1)
    |> Stream.with_index(1)
    |> Stream.chunk_by(fn {false, _} -> false; _ -> true end)
    |> Stream.filter(&elem(hd(&1), 0))
    |> Stream.map(fn lines = [{_, line_num} | _] ->
         {line_num, lines |> Enum.map(&"#{indent}#{elem(&1, 0)}") |> Enum.join}
       end)
    |> Enum.to_list
  end

  defp hashpipe(line) do
    case String.trim_leading(line) do
      "#|" <> code -> code
      _ -> false
    end
  end

end
