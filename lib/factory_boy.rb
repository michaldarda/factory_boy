require 'factory_boy/version'
require 'factory_boy/factory'

require 'active_support/core_ext/string/inflections'

module FactoryBoy
  class FactoryNotFound < StandardError; end
  # name can be :user or User, there could also be passed
  # class option
  def self.define_factory(name, options = {}, &block)
    klass = options.fetch(:class) { const_get(name.to_s.classify) }

    factory_instance = Factory.new(klass)

    __register_factory__(name, factory_instance, klass)

    factory_instance.instance_eval(&block) if block_given?

    factory_instance
  end

  def self.build(name, attributes = {})
    name = name.to_s.underscore.to_sym

    (factory = __factories__[name]) || raise(FactoryNotFound)

    __build_object__(factory, attributes)
  end

  def self.__build_object__(factory_data, attributes = {})
    instance = factory_data.fetch(:class).new
    instance_attributes =
      factory_data.fetch(:instance).attributes.merge(attributes)

    instance.tap do
      instance_attributes.each do |attribute, value|
        instance.send("#{attribute}=", value.is_a?(Proc) ? value.call : value)
      end
    end
  end

  def self.__register_factory__(name, instance, klass)
    __factories__[name.to_s.downcase.to_sym] = {
      class: klass,
      instance: instance
    }
  end

  def self.__factories__
    @factories ||= {}
  end
end
