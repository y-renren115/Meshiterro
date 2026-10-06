require 'minitest/autorun'
require 'erb'
require 'yaml'

class SecretsConfigurationTest < Minitest::Test
  CONFIGURATION = File.expand_path('../../config/secrets.yml', __dir__)

  def with_secret(value)
    previous = ENV['SECRET_KEY_BASE']
    value.nil? ? ENV.delete('SECRET_KEY_BASE') : ENV['SECRET_KEY_BASE'] = value
    yield YAML.safe_load(ERB.new(File.read(CONFIGURATION)).result)
  ensure
    previous.nil? ? ENV.delete('SECRET_KEY_BASE') : ENV['SECRET_KEY_BASE'] = previous
  end

  def test_production_reads_the_supplied_environment_value
    fixture = 'test-only-not-a-real-secret'
    with_secret(fixture) do |config|
      assert_equal fixture, config.fetch('production').fetch('secret_key_base')
    end
  end

  def test_missing_production_secret_does_not_get_a_shared_fallback
    with_secret(nil) do |config|
      assert_nil config.fetch('production').fetch('secret_key_base')
    end
  end

  def test_local_environments_do_not_override_rails_generated_secret
    with_secret(nil) do |config|
      refute config.key?('development')
      refute config.key?('test')
    end
  end
end
