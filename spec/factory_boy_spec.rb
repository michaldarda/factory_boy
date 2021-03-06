require 'spec_helper'

describe FactoryBoy do
  User = Struct.new(:name)

  before do
    # reset global factories list
    FactoryBoy.instance_variable_set('@factories', {})
  end

  it 'allows to define factory' do
    FactoryBoy.define_factory(User)
  end

  it 'allows to build instance of given class' do
    FactoryBoy.define_factory(User)
    instance = FactoryBoy.build(User)

    expect(instance).to be_kind_of(User)
  end

  it 'allows to pass custom parameters' do
    FactoryBoy.define_factory(User)
    instance = FactoryBoy.build(User, name: 'Michał')

    expect(instance.name).to eq 'Michał'
  end

  it 'raises exception if factory is not found' do
    expect { FactoryBoy.build(User, name: 'Michał') }
      .to raise_error(FactoryBoy::FactoryNotFound)
  end

  it 'allows to define value for attributes' do
    FactoryBoy.define_factory(User) do
      name 'Michał'
    end

    instance = FactoryBoy.build(User)

    expect(instance.name).to eq 'Michał'
  end

  it 'allows to define value for attributes' do
    FactoryBoy.define_factory(User) do
      name 'Michał'
    end

    instance = FactoryBoy.build(User, name: 'Przemysław')

    expect(instance.name).to eq 'Przemysław'
  end

  it 'allows to pass symbol instead of class name to define_factory' do
    FactoryBoy.define_factory(:user)

    instance = FactoryBoy.build(:user)

    expect(instance).to be_kind_of(User)
  end

  it 'allows to pass alias class name to define_factory' do
    FactoryBoy.define_factory(:admin, class: User)

    instance = FactoryBoy.build(:admin)

    expect(instance).to be_kind_of(User)
  end

  it 'allows to set lazy evaluated properties' do
    FactoryBoy.define_factory(User) do
      name { 'Michał' }
    end

    instance = FactoryBoy.build(User)

    expect(instance.name).to eq 'Michał'
  end
end
