# Part 1

This is the first part of an assignment where you will build FactoryBoy gem - a simple factory DSL inspired by FactoryGirl.

For the sake of the example, let's assume we have the following class:
```
class User
  attr_accessor :name
end
```
You should then be able to define a factory for this class:
```
FactoryBoy.define_factory(User)
```
and then create instances of the class:
```
FactoryBoy.build(User) # => #<User:0x007fb6c4133c60 @name=nil>
```
The `#build` method should create the instance using the default constructor.

You should also be able to set attributes by passing a hash as the second argument to `#build`:
```
FactoryBoy.build(User, name: "foobar") # => #<User:0x007fb6c4133c60 @name="foobar">
```
Bonus points for using specs to either drive your development or just for test coverage.