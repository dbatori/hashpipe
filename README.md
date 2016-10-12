# HashPipe

> **Work in progress - This project is *NOT* yet published to Hex**

***HashPipe* is a minimalist testing and code documentation tool for Elixir.**

## Installation

Add `hashpipe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:hashpipe, "~> 0.1.0"}]
end
```

Ensure `hashpipe` is started before your application:

```elixir
def application do
  [applications: [:hashpipe]]
end
```

Update your dependencies:

```sh-session
$ mix deps.get
```

## Usage

Let's `use HashPipe` and write some `HashPipe` tests, which are just
consecutive lines starting with `#|`:

```elixir
defmodule MyApp.MyModule do

  use HashPipe

  #| 1 + 1 > 1

  defp sum(a, b), do: a + b

  #| # test a private function defined above this test
  #| sum(1, 2) == 3

  #| # test a public function defined somewhere in this module
  #| a = 1
  #| b = 2
  #| average(a, b) == 1.5

  def average(a, b), do: sum(a, b) / 2

  #| is_atom(Elixir) and 42 in 1..100

  def my_div(_a, 0), do: raise "Devision by zero!"
  def my_div(a, b), do: a / b

  #| # test devision by zero
  #| result = try do
  #|   my_div(1, 0)
  #| rescue
  #|   e -> e
  #| end
  #| result == %RuntimeError{message: "Devision by zero!"}

end
```

Now compile your project and `HashPipe` tests will be automatically executed:

![Screenshot](https://cloud.githubusercontent.com/assets/19773293/19279018/cfe07a8c-8fdf-11e6-9509-1fc9786ad111.png)

Let's make two errors in the first and last tests:

```elixir
defmodule MyApp.MyModule do

  use HashPipe

  #| 1 + 1 > 2

  defp sum(a, b), do: a + b

  #| # test a private function defined above this test
  #| sum(1, 2) == 3

  #| # test a public function defined somewhere in this module
  #| a = 1
  #| b = 2
  #| average(a, b) == 1.5

  def average(a, b), do: sum(a, b) / 2

  #| is_atom(Elixir) and 42 in 1..100

  def my_div(_a, 0), do: raise "Devision by zero!"
  def my_div(a, b), do: a / b

  #| # test devision by zero
  #| result = try do
  #|   my_div(1, 0)
  #| rescue
  #|   e -> e
  #| end
  #| result

end
```

Compile the project again and check the output:

![Screenshot](https://cloud.githubusercontent.com/assets/19773293/19279025/d87cabf2-8fdf-11e6-843c-1def5d16a7f3.png)

**Note that a `HashPipe` test succeeds if it returns true and fails otherwise.
If it fails, its return value is printed after the test.**

You can also `use HashPipe` to check return values of private functions or (almost) any Elixir expressions:

```elixir
defmodule MyApp.MyModule do

  use HashPipe

  #| emphasize("elixir")

  defp emphasize(word) do
    word
    |> String.upcase
    |> String.graphemes
    |> Enum.intersperse(" ")
    |> Enum.join
  end

  #| highlight("Chuck Norris can access private methods.", "private")

  defp highlight(text, word) do
    String.replace(text, word, emphasize(word))
  end

  #| 1..9
  #| |> Enum.map(&String.duplicate("|", 5 - abs(&1 - 5)))
  #| |> Enum.join("  ")

end
```
Compile it and you will get something like this:

![Screenshot](https://cloud.githubusercontent.com/assets/19773293/19325639/5b9e1966-90c7-11e6-9c39-94d8d614ed51.png)
