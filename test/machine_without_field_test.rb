require_relative 'test_helper'

class MachineWithoutFieldTest < BaseTestCase
  def setup
    @model = new_model
    StateMachines::Machine.new(@model, :status)
  end

  def test_should_define_field_with_string_type
    field = @model.fields['status']
    refute_nil field
    assert_equal String, field.type
  end
end