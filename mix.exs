defmodule HashPipe.Mixfile do
  use Mix.Project

  def project do
    [app: :hashpipe,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: "Minimalist testing and code documentation tool for Elixir",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "HashPipe",
     source_url: "https://github.com/dbatori/hashpipe",
     docs: [main: "HashPipe"]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev}]
  end
  
  defp package do
    [name: :hashpipe,
     maintainers: ["Daniel Batori"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/dbatori/hashpipe"}]
  end
  
end
