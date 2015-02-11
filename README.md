# StateMachines Mongoid Integration

The Mongoid integration adds support for automatically
saving the record, named scopes, validation errors.

## Installation

Add this line to your application's Gemfile:

    gem 'state_machines-mongoid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install state_machines-mongoid

## Usage

```ruby
class Vehicle
  include Mongoid::Document

  state_machine :initial => :parked do
    before_transition :parked => any - :parked, :do => :put_on_seatbelt
    after_transition any => :parked do |vehicle, transition|
      vehicle.seatbelt_on = 'off'
    end
    around_transition :benchmark

    event :ignite do
      transition :parked => :idling
    end

    state :first_gear, :second_gear do
      validates_presence_of :seatbelt_on
    end
  end

  def put_on_seatbelt
    self.seatbelt_on = 'on'
  end

  def benchmark
    #...
    yield
    #...
  end
end
```

Dependencies

Mongoid 4.0+

## Contributing

1. Fork it ( https://github.com/state-machines/state_machines-mongoid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

