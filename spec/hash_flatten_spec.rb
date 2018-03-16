require 'spec_helper'

RSpec.describe HashFlatten do
  using HashFlatten

  describe '#squish_levels' do
    it 'flattens hash to keys concatenated with period' do
      hash =
        { a: 'a',
          b: { a: 'b' },
          c: { b: { a: 'c' } } }

      expect(hash.squish_levels).to match({ 'a' => 'a', 'b.a' => 'b', 'c.b.a' => 'c' })
    end

    it 'transforms keys to strings' do
      expect({ x: 'x' }.squish_levels).to match({ 'x' => 'x' })
    end

    it 'squishes only sub-Hashes, no other classes similar to Hash' do
      HashLike = Struct.new(:'a.b', :b)

      expect({ a: HashLike.new('a', 'b') }.squish_levels).to match({ 'a' => HashLike.new('a', 'b') })
    end
  end

  describe '#stretch_to_levels' do
    it 'hash with key with period is stretched to new level on period' do
      expect({ 'a.b' => 'a' }.stretch_to_levels).to match( { 'a' => { 'b' => 'a' } })
    end

    it 'hash with key with multiple periods is stretched to new level on every period' do
      expect({ 'a.b.c' => 'a' }.stretch_to_levels).to match({ 'a' => { 'b' => { 'c' => 'a' } } })
    end

    it "if there are keys with period which would resolve to same sub level they don't override themselvs but properly merge their's values" do
      hsh = { 'a.b' => 'a', 'a.c' => 'a' }

      structured_hash = { 'a' => { 'b' => 'a', 'c' => 'a' } }

      expect(hsh.stretch_to_levels).to match(structured_hash)
    end

    it "if there are keys with periods which would resolve to same multiple sub levels they don't override themselvs but properly merge their's values" do
      hsh = { 'a' => 'a', 'b.a' => 'b', 'c.b.a' => 'c', 'c.b.b' => 'd' }

      structured_hash =
        { 'a' => 'a',
          'b' => { 'a' => 'b' },
          'c' => { 'b' => { 'a' => 'c', 'b' => 'd' } } }

      expect(hsh.stretch_to_levels).to match(structured_hash)
    end

    it 'transforms keys to strings' do
      expect({ :'a' => 'a' }.stretch_to_levels).to match({ 'a' => 'a' })
    end

    it 'hash with symbol keys with period is also stretched' do
      expect({ :'a.b' => 'a' }.stretch_to_levels).to match({ 'a' => { 'b' => 'a' } })
    end
  end
end
