require_relative 'test_helper'

class MachineWithFieldTest < BaseTestCase
  def setup
    @model = new_model do
      field :status, :type => Integer
    end
    StateMachines::Machine.new(@model, :status)
  end

  def test_should_not_redefine_field
    field = @model.fields['status']
    refute_nil field
    assert_equal Integer, field.type
  end
end