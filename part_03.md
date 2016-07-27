# Part 3

Building on the previous two assignments, extend FactoryBoy to handle the following:
```
FactoryBoy.define_factory(:user) do
  name "foobar"
end

FactoryBoy.build(:user) # => #<User:0x007fb98492834 @name="foobar">
```
and
```
FactoryBoy.define_factory(:admin, class: User) do
  name "foobar"
  admin true
end

FactoryBoy.build(:admin) # => #<User:0x007fb98492834 @name="foobar" @admin=true>
```