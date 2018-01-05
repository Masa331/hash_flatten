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
    let(:hsh) do
      { 'a' => 'a', 'b.a' => 'b', 'c.b.a' => 'c', 'c.b.b' => 'd' }
    end

    let(:structured_hash) do
      { 'a' => 'a',
        'b' => { 'a' => 'b' },
        'c' => { 'b' => { 'a' => 'c', 'b' => 'd' } } }
    end


    it 'structures hash by splitting keys at period' do
      expect(hsh.structure).to match(structured_hash)
    end
  end
end
