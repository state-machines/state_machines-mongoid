require_relative 'test_helper'

class MachineWithEventAttributesOnAutosaveTest < BaseTestCase
  def setup
    @vehicle_model = new_model(:vehicle) do
      belongs_to :owner, :class_name => 'MongoidTest::Owner'
    end
    MongoidTest.const_set('Vehicle', @vehicle_model)

    @owner_model = new_model(:owner)
    MongoidTest.const_set('Owner', @owner_model)

    machine = StateMachines::Machine.new(@vehicle_model)
    machine.event :ignite do
      transition :parked => :idling
    end

    @owner = @owner_model.create
  end

  def test_should_persist_many_association
    @owner_model.has_many :vehicles, :class_name => 'MongoidTest::Vehicle', :autosave => true
    @vehicle = @vehicle_model.create(:state => 'parked', :owner_id => @owner.id)

    @owner.vehicles[0].state_event = 'ignite'
    @owner.save

    @vehicle.reload
    assert_equal 'idling', @vehicle.state
  end

  def test_should_persist_one_association
    @owner_model.has_one :vehicle, :class_name => 'MongoidTest::Vehicle', :autosave => true
    @vehicle = @vehicle_model.create(:state => 'parked', :owner_id => @owner.id)

    @owner.vehicle.state_event = 'ignite'
    @owner.save

    @vehicle.reload
    assert_equal 'idling', @vehicle.state
  end

  def teardown
    MongoidTest.class_eval do
      remove_const('Vehicle')
      remove_const('Owner')
    end
    super
  end
end
