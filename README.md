# HashPipe

> **Work in progress - This project is *NOT* yet published to Hex**

***HashPipe* is a minimalist testing and code documentation tool for Elixir.**

## Installation

  1. Add `hashpipe` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:hashpipe, "~> 0.1.0"}]
    end
    ```

  2. Ensure `hashpipe` is started before your application:

    ```elixir
    def application do
      [applications: [:hashpipe]]
    end
    ```

  3. Update your dependencies:

    ```sh-session
    $ mix deps.get
    ```
