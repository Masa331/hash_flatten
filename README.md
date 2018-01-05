# HashFlatten

Two methods i sometimes miss on Hash.

## `#destructure`

hash = { a: 'a',
         b: { a: 'b' },
         c: { b: { a: 'c' } } }

hash.destructure =>

  { 'a' => 'a',
    'b.a' => 'b',
    'c.b.a' => 'c' }

## `#structure`

hash = { 'a' => 'a',
         'b.a' => 'b',
         'c.b.a' => 'c' }

hash.structure =>

{ 'a' => 'a',
  'b' => { 'a' => 'b' },
  'c' => { 'b' => { 'a' => 'c' } } }

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hash_flatten'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hash_flatten

## Usage

Use as refinement:
```
class MyClass
  using HashFlatten
end
```
now you can call `#destructure` od `#structure` on hashes in `MyClass`.

Here is an excellent blog post on refinements if you didn't use them before: http://interblah.net/why-is-nobody-using-refinements

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
