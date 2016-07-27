require "factory_boy/version"

module FactoryBoy
  class FactoryNotFound < StandardError; end
  class Factory
   attr_reader :attributes 
    
    def initialize(name)
      @name = name
      
      @attributes = {}
    end
    
    def method_missing(meth, *args, &blk)
      @attributes[meth] = args.first
    end
  end
    
  def self.factories
    @factories ||= {}
  end 
  
  def self.define_factory(name, options = {}, &block)
    klass = if options[:class]
      options[:class] 
    elsif name.is_a?(Symbol)
      const_get(name.to_s.capitalize) 
    end
    
    factory_instance = Factory.new(klass)
    
    store_factory(name, factory_instance, klass)
    
    factory_instance.instance_eval(&block) if block_given?
    factory_instance
  end
  
  def self.build(klass, attributes = {})
    factory = if klass.is_a?(Symbol)
      const_get(klass.to_s.capitalize) rescue factories[klass]
    else
      find_factory(klass) 
    end
    
    factory or raise FactoryNotFound
    
    klass = factory[:klass]
    
    factory = factory[:instance] if factory
  
    instance_attributes = factory.attributes.merge(attributes)
   
    instance = klass.new
      
    instance_attributes.each do |attribute, value|
      instance.send("#{attribute}=", value)
    end
      
    instance
  end
  
  def self.find_factory(factory_name, klass = nil)
    factory_instance = factories[factory_name]
    factory_instance && factory_instance[:instance]
  end
  
  def self.store_factory(factory_name, factory_instance, klass = nil)
    factory_data = {
      instance: factory_instance,
      klass: klass
    }
    
    factories[factory_name] = factory_data
    factories[klass] = factory_data if klass
  end 
end
