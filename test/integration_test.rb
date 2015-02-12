require_relative 'test_helper'

class IntegrationTest < BaseTestCase
  def test_should_have_an_integration_name
    assert_equal :mongoid, StateMachines::Integrations::Mongoid.integration_name
  end

  def test_should_match_if_class_includes_mongoid
    assert StateMachines::Integrations::Mongoid.matches?(new_model)
  end

  def test_should_not_match_if_class_does_not_include_mongoid
    assert !StateMachines::Integrations::Mongoid.matches?(Class.new)
  end

  def test_should_have_defaults
    assert_equal({:action => :save, :use_transactions => false}, StateMachines::Integrations::Mongoid.defaults)
  end

  def test_should_have_a_locale_path
    refute_nil StateMachines::Integrations::Mongoid.locale_path
  end
end