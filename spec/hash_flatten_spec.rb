require "spec_helper"

RSpec.describe 'HashFlatten refinement' do
  using HashFlatten

  describe '#destructure' do
    let(:hsh) do
      { a: 'a',
        b: { a: 'b' },
        c: { b: { a: 'c' } } }
    end

    let(:destructured_hash) do
      { 'a' => 'a', 'b.a' => 'b', 'c.b.a' => 'c' }
    end

    it 'flattens hash to keys concatenated with period' do
      expect(hsh.destructure).to match(destructured_hash)
    end
  end

  describe '#structure' do
    it 'simple hash' do
      hsh = { 'a' => 'a' }

      structured_hash = { 'a' => 'a' }

      expect(hsh.structure).to match(structured_hash)
    end

    it 'harder hash' do
      hsh = { 'a' => 'a', 'b' => 'b' }

      structured_hash = { 'a' => 'a', 'b' => 'b' }

      expect(hsh.structure).to match(structured_hash)
    end

    it 'even harder hash' do
      hsh = { 'a.b' => 'a' }

      structured_hash = { 'a' => { 'b' => 'a' } }

      expect(hsh.structure).to match(structured_hash)
    end

    it 'even even harder hash' do
      hsh = { 'a.b.c' => 'a' }

      structured_hash = { 'a' => { 'b' => { 'c' => 'a' } } }

      expect(hsh.structure).to match(structured_hash)
    end

    it 'a lot harder hash' do
      hsh = { 'a.b' => 'a', 'a.c' => 'a' }

      structured_hash = { 'a' => { 'b' => 'a', 'c' => 'a' } }

      expect(hsh.structure).to match(structured_hash)
    end

    it 'even a lot harder hash' do
      hsh = { 'a.b' => 'a', 'a.c.a' => 'a', 'a.c.b' => 'a' }

      structured_hash = { 'a' => { 'b' => 'a', 'c' => { 'a' => 'a', 'b' => 'a' } } }

      expect(hsh.structure).to match(structured_hash)
    end

    it 'kinda harder' do
      hsh =
        { 'a' => 'a', 'b.a' => 'b', 'c.b.a' => 'c', 'c.b.b' => 'd' }

      structured_hash =
      { 'a' => 'a',
        'b' => { 'a' => 'b' },
        'c' => { 'b' => { 'a' => 'c', 'b' => 'd' } } }
      expect(hsh.structure).to match(structured_hash)
    end

    it 'hardest so far' do
      hash = { "a.b.c.f" => :x, "a.b.d.g.i" => :x, "a.b.e.h" => :x }

      structured_hash =
        { 'a' => { 'b' => { 'c' => { 'f' => :x }, 'd' => { 'g' => { 'i' => :x } }, 'e' => { 'h' => :x } } }}

      expect(hash.structure).to match(structured_hash)
    end
  end
end
