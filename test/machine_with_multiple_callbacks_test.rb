require_relative 'test_helper'

class MachineWithMultipleTransitionsTest < BaseTestCase
  def setup
    @callbacks = []

    @model = new_model
    @machine = StateMachines::Machine.new(@model)
    @machine.event :ignite do
      transition :parked => :idling
    end
    @machine.event :shift_up do
      transition :idling => :first_gear
    end
    @record = @model.new(state: 'parked')
  end

  def test_should_run_before_callback_for_every_transition
    before_count = 0
    @machine.before_transition { before_count += 1 }
    
    @record.ignite
    assert_equal 1, before_count
    @record.shift_up
    assert_equal 2, before_count
  end

  def test_should_run_after_callback_for_every_transition
    after_count = 0
    @machine.after_transition { after_count += 1 }

    @record.ignite
    assert_equal 1, after_count
    @record.shift_up
    assert_equal 2, after_count
  end
end
