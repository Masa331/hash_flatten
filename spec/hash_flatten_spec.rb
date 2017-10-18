require "spec_helper"

RSpec.describe 'HashFlatten refinement' do
  using HashFlatten

  describe '#flatten' do
    let(:hsh) do
      { a: 'a',
        b: { a: 'b' },
        c: { b: { a: 'c' } } }
    end

    let(:flattened_hash) do
      { 'a' => 'a', 'b.a' => 'b', 'c.b.a' => 'c' }
    end

    it 'flattens hash to keys concatenated with comma' do
      expect(hsh.flatten).to match(flattened_hash)
    end
  end
end
