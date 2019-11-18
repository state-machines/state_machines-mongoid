require_relative 'test_helper'

class MachineWithLimitedFieldsTest < BaseTestCase
  def setup
    @model = new_model
    @machine = StateMachines::Machine.new(@model, :initial => :parked)
    @machine.state :idling

    @record = @model.create
  end

  def test_should_not_set_value_when_exclude_field_in_query
    record = @model.where(id: @record.id).only(:_id).first
    assert_equal ["_id"], record.attributes.keys
  end

  def test_should_set_value_when_include_field_in_query
    record = @model.where(id: @record.id).only(:_id, :state).first
    assert_equal "parked", record.state
  end

  def test_should_fail_if_access_when_exclude_field_in_query
    record = @model.where(id: @record.id).only(:_id).first
    assert_raises(ActiveModel::MissingAttributeError) { record.state }
  end
end
