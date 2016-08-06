module FactoryBoy
  class DefinitionProxy < BasicObject
    attr_reader :attributes

    def initialize
      @attributes = {}
    end

    # treating all the methods as attributes
    def method_missing(attribute, *args, &blk)
      @attributes[attribute] = blk || args.first
    end
  end
end
