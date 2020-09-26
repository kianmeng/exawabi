defmodule ExAwabi.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :exawabi,
      escript: [main_module: ExAwabi.CLI],
      version: @version,
      elixir: "~> 1.9",
      name: "ExAwabi",
      description: "A morphological analyzer using mecab dictionary.",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [
        awabi_nif: [
          mode: (if Mix.env() == :prod, do: :release, else: :debug)
        ]
      ],
      package: package(),
      docs: docs(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["Hajime Nakagami"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nakagami/exawabi"}
    ]
  end

  defp docs() do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extras: ["README.md"]
    ]
  end

  defp deps do
    [
      {:rustler, "~> 0.21"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
