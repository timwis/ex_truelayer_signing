import Config

if config_env() == :test do
  config :ex_truelayer_signing,
    key_id: "test_key_id",
    private_key: File.read!("test/support/test_keys/ec512-private-key.pem"),
    public_key: File.read!("test/support/test_keys/ec512-public-key.pem")
end
