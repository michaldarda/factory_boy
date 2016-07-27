require "factory_boy/version"

module FactoryBoy
  class FactoryNotFound < StandardError; end
  class Factory
    def initialize(name)
      @name = name
    end
  end
    
  def self.factories
    @factories ||= {}
  end 
  
  def self.define_factory(klass)
    factories[klass] = Factory.new(klass)
  end
  
  def self.build(klass, attributes = {})
    factories[klass] or raise FactoryNotFound
    
    instance = klass.new
      
    attributes.each do |attribute, value|
      instance.send("#{attribute}=", value)
    end
      
    instance
  end
end
