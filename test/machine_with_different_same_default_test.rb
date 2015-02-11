require_relative 'test_helper'

class MachineWithDifferentSameDefaultTest < BaseTestCase
  def setup
    @original_stderr, $stderr = $stderr, StringIO.new

    @model = new_model do
      field :status, :type => String, :default => 'parked'
    end
    @machine = StateMachines::Machine.new(@model, :status, :initial => :parked)
    @record = @model.new
  end

  def test_should_use_machine_default
    assert_equal 'parked', @record.status
  end

  def test_should_not_generate_a_warning
    refute_match(/have defined a different default/, $stderr.string)
  end

  def teardown
    $stderr = @original_stderr
    super
  end
end