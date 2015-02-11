require 'minitest/reporters'
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
require 'state_machines-mongoid'
require 'minitest/autorun'

# Env variables can be set to test to another database
ENV['MONGO_HOST'] ||= 'localhost'
ENV['MONGO_PORT'] ||= '27017'

HOST = ENV['MONGO_HOST']
PORT = ENV['MONGO_PORT'].to_i
DB_NAME = 'state-machines-mongoid_test'

CONFIG = {
  sessions: {
    default: {
      database: DB_NAME,
      hosts: [ "#{HOST}:#{PORT}" ]
    }
  }
}

# Set the database that the spec suite connects to.
Mongoid.configure do |config|
  config.load_configuration(CONFIG)
end

# Module for test models
module MongoidTest
end


class BaseTestCase < Minitest::Test
  def default_test
  end

  def teardown
    if @table_names
      db = Mongoid::Sessions.default
      db.collections.each {|c| c.drop if @table_names.include?(c.name)}
    end
  end

  protected
    # Creates a new Mongoid model (and the associated table)
    def new_model(name = :foo, &block)
      table_name = "#{name}_#{rand(1000000)}"
      @table_names ||= []
      @table_names << table_name

      model = Class.new do
        (class << self; self; end).class_eval do
          define_method(:name) { "MongoidTest::#{name.to_s.capitalize}" }
          define_method(:to_s) { self.name }
        end
      end

      model.class_eval do
        include Mongoid::Document
        store_in collection: table_name

        field :state, :type => String
      end
      model.class_eval(&block) if block_given?
      model
    end

    # Creates a new Mongoid observer
    def new_observer(model, &block)
      observer = Class.new(Mongoid::Observer) do
        attr_accessor :notifications

        def initialize
          super
          @notifications = []
        end
      end

      (class << observer; self; end).class_eval do
        define_method(:name) do
          "#{model.name}Observer"
        end
      end

      observer.observe(model)
      observer.class_eval(&block) if block_given?
      observer
    end
  end

