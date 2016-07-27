require 'factory_boy/version'

module FactoryBoy
  class FactoryNotFound < StandardError; end
  class Factory
    attr_reader :attributes

    def initialize(name)
      @name = name

      @attributes = {}
    end

    def method_missing(meth, *args)
      @attributes[meth] = args.first
    end
  end

  def self.factories
    @factories ||= {}
  end

  # name can be :user or User, there could also be passed
  # class option
  def self.define_factory(name, options = {}, &block)
    klass = options.fetch(:class) { const_get(name.to_s.capitalize) }

    factory_instance = Factory.new(klass)

    factories[name.to_s.downcase.to_sym] = {
      class: klass,
      instance: factory_instance
    }

    factory_instance.instance_eval(&block) if block_given?

    factory_instance
  end

  def self.build(name, attributes = {})
    name = name.to_s.downcase.to_sym

    (factory = factories[name]) || raise(FactoryNotFound)

    instance_attributes = factory.fetch(:instance).attributes.merge(attributes)
    instance = factory.fetch(:class).new

    instance_attributes.each do |attribute, value|
      instance.send("#{attribute}=", value)
    end

    instance
  end
end
