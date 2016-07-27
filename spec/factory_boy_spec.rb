require 'spec_helper'

describe FactoryBoy do
  before do
    FactoryBoy.instance_variable_set("@factories", {})
  end
  
  it 'allows to define factory' do
    User = Struct.new(:name)
    
    user_factory = FactoryBoy.define_factory(User)
    
    expect(user_factory).to be_kind_of(FactoryBoy::Factory)
  end
  
  it 'allows to build instance of given class' do
    User = Struct.new(:name)
    
    FactoryBoy.define_factory(User)
    instance = FactoryBoy.build(User)
    
    expect(instance).to be_kind_of(User)
  end
  
  it 'allows to pass custom parameters' do
    User = Struct.new(:name)
    
    FactoryBoy.define_factory(User)
    instance = FactoryBoy.build(User, name: "Michał")
    
    expect(instance.name).to eq "Michał"
  end
  
  it 'raises exception if factory is not found' do
    expect{FactoryBoy.build(User, name: "Michał")}.to raise_error(FactoryBoy::FactoryNotFound)
  end 
  
  it 'allows to define value for attributes' do
    User = Struct.new(:name)
    
    FactoryBoy.define_factory(User) do
      name "Michał"
    end
    
    instance = FactoryBoy.build(User)
    
    expect(instance.name).to eq "Michał"
  end 
  
  it 'allows to define value for attributes' do
    User = Struct.new(:name)
    
    FactoryBoy.define_factory(User) do
      name "Michał"
    end
    
    instance = FactoryBoy.build(User, name: "Przemysław")
    
    expect(instance.name).to eq "Przemysław"
  end 
end
