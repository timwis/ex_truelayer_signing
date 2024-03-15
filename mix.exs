defmodule ExTrueLayerSigning.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_truelayer_signing,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jose, "~> 1.11"},
      {:jason, "~> 1.2"},
      {:tesla, "~> 1.5.1"}
    ]
  end
end
