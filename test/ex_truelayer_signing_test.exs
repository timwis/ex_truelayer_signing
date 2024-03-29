defmodule ExTrueLayerSigningTest do
  use ExUnit.Case

  alias Tesla.Env
  alias ExTrueLayerSigning
  alias ExTrueLayerSigning.Request
  alias ExTrueLayerSigning.SigningMiddleware

  test "adds tl-signature header" do
    request = %Env{
      method: :post,
      url: "https://example.com/mandates",
      body: Jason.encode!(%{"foo" => "bar"}),
      headers: [{"Idempotency-Key", "123"}]
    }

    assert {:ok, env} = SigningMiddleware.call(request, [], [])
    tl_signature = Tesla.get_header(env, "tl-signature")
    assert tl_signature != nil
  end

  test "generated signature verifies" do
    request = %Request{
      method: :post,
      path: "/mandates",
      body: Jason.encode!(%{"foo" => "bar"}),
      headers: [{"Idempotency-Key", "123"}]
    }

    assert {:ok, tl_signature} = ExTrueLayerSigning.sign(request)

    signed_request = put_header(request, "tl-signature", tl_signature)
    assert :ok = ExTrueLayerSigning.verify(signed_request)
  end

  defp put_header(%Request{} = request, key, value) do
    headers = List.keystore(request.headers, key, 0, {key, value})
    %{request | headers: headers}
  end
end
