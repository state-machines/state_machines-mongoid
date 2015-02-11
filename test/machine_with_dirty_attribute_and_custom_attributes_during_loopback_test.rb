require_relative 'test_helper'

class MachineWithDirtyAttributeAndCustomAttributesDuringLoopbackTest < BaseTestCase
  def setup
    @model = new_model do
      field :status, :type => String
    end
    @machine = StateMachines::Machine.new(@model, :status, :initial => :parked)
    @machine.event :park

    @record = @model.create

    @transition = StateMachines::Transition.new(@record, @machine, :park, :parked, :parked)
    @transition.perform(false)
  end

  def test_should_include_state_in_changed_attributes
    assert_equal [], @record.changed
  end

  def test_should_track_attribute_changes
    assert_equal nil, @record.send(:attribute_change, 'status')
  end
end