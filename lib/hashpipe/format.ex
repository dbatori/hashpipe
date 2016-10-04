defmodule HashPipe.Format do

  @moduledoc """
  Functions related to formatting.
  """

  @doc """
  Returns test results as a formatted string based on the `tests` and the
  `file` and `module` (which contain the tests).

  If ANSI coloring is enabled, return value also contains ANSI color codes.

  `tests` is a list of `[line_num, test, result]` lists, where `test` is a
  `HashPipe` test starting at line number `line_num` and `result` is its
  evaluated value.
  """
  def results(tests, file, module) do
    fails = Enum.filter tests, fn [_, _, result] -> result != true end
    num_fails = length(fails)
    sum = summary(length(tests), num_fails, module, Path.relative_to_cwd(file))
    sum_color = summary_color(num_fails)
    "#{IO.ANSI.format [sum_color, :bright, sum]}#{failures fails}"
  end

  defp pluralize(1, singular), do: singular
  defp pluralize(_, singular), do: "#{singular}s"

  defp summary(num_tests, num_fails, module, file) do
    "#{num_tests} #{pluralize num_tests, "HashPipe test"}, " <>
    "#{num_fails} #{pluralize num_fails, "failure"} " <>
    "in #{inspect module} (#{file})"
  end

  defp summary_color(0), do: :green
  defp summary_color(_num_fails), do: :red

  defp failures(fails) do
    for {[line_num, test, result], index} <- Enum.with_index(fails, 1), into: "" do
      num_index_chars = (index |> :math.log10 |> trunc) + 1
      index_indent = String.duplicate(" ", max(0, 3 - num_index_chars))
      ~s"""
      \n\n#{index_indent}#{IO.ANSI.format [:bright, inspect(index), ") line: ", inspect(line_num)]}
      #{IO.ANSI.format [:red, :bright, test, :cyan, "  -> ", inspect(result)]}
      """
    end
  end

end
