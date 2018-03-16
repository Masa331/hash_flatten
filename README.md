# HashFlatten [![Build Status](https://travis-ci.org/Masa331/hash_flatten.svg?branch=master)](https://travis-ci.org/Masa331/hash_flatten)

Flatten nested Hash to one level depth with keys joined with a dot and vice versa.

Content:
1. [About](#about)
2. [How to](#how-to)
    1. [Installation](#installation)
    2. [Usage](#usage)
    3. [squish_levels](#squish_levels)
    4. [stretch_to_levels](#stretch_to_levels)
    5. [Notes](#notes)
3. [License](#license)

## About

This gem includes Refinement which adds `#squish_levels` and `#stretch_to_levels` to Hash. With them you can transform this hash: `{ a: { b: 'b', c: 'c' } }` to this: `{ 'a.b' => 'b', 'a.c' => 'c' }` and vice versa. I use these to transform Rails locales to somehow readable csv for external translators or showing XML structure(transformed to a hash) in a table.

## How to

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'hash_flatten'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hash_flatten

### Usage

Use as a Refinement:
```
class MyClass
  using HashFlatten
end
```
now you can call `#squish_levels` and `#stretch_to_levels` on hashes in `MyClass`(lexically).

Here is an excellent blog post on Refinements if you didn't use them before: http://interblah.net/why-is-nobody-using-refinements

### `#squish_levels`

```ruby
hash = { a: 'a',
         b: { a: 'b' },
         c: { b: { a: 'c' } } }

hash.squish_levels =>

  { 'a' => 'a',
    'b.a' => 'b',
    'c.b.a' => 'c' }
```

### `#stretch_to_levels`

```ruby
hash = { 'a' => 'a',
         'b.a' => 'b',
         'c.b.a' => 'c' }

hash.stretch_to_levels =>

{ 'a' => 'a',
  'b' => { 'a' => 'b' },
  'c' => { 'b' => { 'a' => 'c' } } }
```

### Notes

Some things to know:

* whenever you call `#squish_levels` or `#stretch_to_levels` returned hash has keys transformed to strings
* squishes or stretches only sub Hashes, other hash-like structure aren't touched(`#to_h` isn't called on values..)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
