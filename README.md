# ExTrueLayerSigning

Module for signing and verifying HTTP requests to the TrueLayer API.

## Installation

The package can be installed by adding `ex_truelayer_signing` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_truelayer_signing, "~> 0.1.0"}
  ]
end
```

## Usage

### Via middleware
The easiest way to use this library is via the Tesla middleware it ships with,
`ExTrueLayerSigning.SigningMiddleware`.

```elixir
defmodule TrueLayer do
  use Tesla

  plug ExTrueLayerSigning.SigningMiddleware
  
  def create_payment(mandate_id, amount) do
    request_body = %{...}
    headers = [{"idempotency-key", UUID.uuid4()}]

    post("/payments", request_body, %{headers: headers})
  end

end
```

Alternatively, you can sign and verify requests manually

### Signing a request

```elixir
request = %ExTrueLayerSigning.Request{
  method: :post,
  path: "/mandates",
  body: Jason.encode!(%{"foo" => "bar"}),
  headers: [{"Idempotency-Key", "123"}]
}

{:ok, tl_signature} = ExTrueLayerSigning.sign(request)
put_header(request, "tl-signature", tl_signature)
```

### Verify a request signature

```elixir
request = %ExTrueLayerSigning.Request{
  method: :post,
  path: "/mandates",
  body: Jason.encode!(%{"foo" => "bar"}),
  headers: [
    {"Idempotency-Key", "123"},
    {"tl-signature", "eyJhbGciOiJFUzUxM..."}
  ]
}
:ok = ExTrueLayerSigning.verify(signed_request)
```
