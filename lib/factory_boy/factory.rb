module FactoryBoy
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
end
