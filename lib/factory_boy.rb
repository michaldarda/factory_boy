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
  
  def self.define_factory(klass, &block)
    factories[klass] = Factory.new(klass)
    factories[klass].instance_eval(&block) if block_given?
    factories[klass]
  end
  
  def self.build(klass, attributes = {})
    factory = factories[klass] or raise FactoryNotFound
    
    instance_attributes = factory.attributes.merge(attributes)
    
    instance = klass.new
      
    instance_attributes.each do |attribute, value|
      instance.send("#{attribute}=", value)
    end
      
    instance
  end
end
