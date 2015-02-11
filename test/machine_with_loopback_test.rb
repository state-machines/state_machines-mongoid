require_relative 'test_helper'

class MachineWithLoopbackTest < BaseTestCase
  def setup
    @model = new_model do
      field :updated_at, :type => Time

      before_update do |record|
        record.updated_at = Time.now
      end
    end

    @machine = StateMachines::Machine.new(@model, :initial => :parked)
    @machine.event :park

    @record = @model.create(:updated_at => Time.now - 1)
    @transition = StateMachines::Transition.new(@record, @machine, :park, :parked, :parked)

    @timestamp = @record.updated_at
    @transition.perform
  end

  def test_should_update_record
    refute_equal @timestamp, @record.updated_at
  end
end