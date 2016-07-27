# Part 2

In this assignment you will extend FactoryBoy to be able to set default attribute values.

Again we're using the `User` class as an example. This is how it should work:
```
FactoryBoy.define_factory(User) do
  name "foobar"
end

FactoryBoy.build(User) # => #<User:0x007fb6c4133c60 @name="foobar">
```
These defaults should be overridable:
```
FactoryBoy.build(User, name: "FOOBAR") # => #<User:0x007fb6c4133c60 @name="FOOBAR">
```
Again, bonus points for test coverage.
