require_relative 'test_helper'

class MachineWithAliasedFieldTest < BaseTestCase
  def setup
    @model = new_model do
      field :status, :as => :vehicle_status
    end

    @machine = StateMachines::Machine.new(@model, :vehicle_status)
    @machine.state :parked

    @record = @model.new
  end

  def test_should_check_custom_attribute_for_predicate
    @record.vehicle_status = nil
    assert !@record.vehicle_status?(:parked)

    @record.vehicle_status = 'parked'
    assert @record.vehicle_status?(:parked)
  end
end