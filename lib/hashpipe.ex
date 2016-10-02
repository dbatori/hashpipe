defmodule HashPipe do

  @doc false
  defmacro __using__(_opts) do
    quote do
      @before_compile HashPipe
      @after_compile HashPipe
    end
  end

  def check(tests, file, module) do
    IO.puts HashPipe.Format.results(tests, file, module)
  end

  @doc false
  defmacro __before_compile__(_env) do
    tests = for {line_num, test} <- HashPipe.Parse.file(__CALLER__.file, " ") do
      opts = [file: __CALLER__.file, line: line_num]
      [line_num, test, Code.string_to_quoted!(test, opts)]
    end
    quote do
      def hashpipe do
        HashPipe.check(unquote(tests), __ENV__.file, __MODULE__)
      end
    end
  end

  @doc false
  def __after_compile__(env, _bytecode) do
    apply env.module, :hashpipe, []
  end

end
