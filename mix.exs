defmodule ExTrueLayerSigning.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_truelayer_signing,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/timwis/ex_truelayer_signing"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:jose, "~> 1.11"},
      {:jason, "~> 1.2"},
      {:tesla, "~> 1.5.1"}
    ]
  end

  defp description() do
    "Module for signing and verifying HTTP requests to the TrueLayer API."
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/timwis/ex_truelayer_signing"}
    ]
  end
end
