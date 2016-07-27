module FactoryBoy
  class Factory
    attr_reader :attributes

    def initialize(name)
      @name = name

      @attributes = {}
    end

    # treating all the methods as attributes
    def method_missing(attribute, *args)
      @attributes[attribute] = args.first
    end
  end
end
