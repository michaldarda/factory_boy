require 'factory_boy/version'
require 'factory_boy/definition_proxy'

module FactoryBoy
  class FactoryNotFound < StandardError; end
  class << self
    # name can be :user or User, there could also be passed
    # class option
    def define_factory(name, options = {}, &block)
      klass = options.fetch(:class) { const_get(symbol_to_class_name(name)) }

      factory_instance = DefinitionProxy.new

      register_factory(name, factory_instance, klass)

      factory_instance.instance_eval(&block) if block_given?
    end

    def build(name, attributes = {})
      (factory = factories[normalize_name(name)]) || raise(FactoryNotFound)

      build_object(factory, attributes)
    end

    private

    def build_object(factory_data, attributes = {})
      instance = factory_data.fetch(:class).new
      instance_attributes =
        factory_data.fetch(:instance).attributes.merge(attributes)

      instance.tap do
        instance_attributes.each do |attribute, value|
          instance.send("#{attribute}=", attribute_value(value))
        end
      end
    end

    def register_factory(name, instance, klass)
      factories[normalize_name(name)] = {
        class: klass,
        instance: instance
      }
    end

    def symbol_to_class_name(sym)
      sym.to_s.capitalize
    end

    def normalize_name(name)
      name.to_s.downcase.to_sym
    end

    def attribute_value(value)
      value.respond_to?(:call) ? value.call : value
    end

    def factories
      @factories ||= {}
    end
  end
end
