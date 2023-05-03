require "rails_helper"

RSpec.describe Base62 do
  let(:cases) do
    {
      '0' => 0,
      'A' => 10,
      'z' => 61,
      'E7W' => 123456
    }
  end

  describe '.encode' do
    context 'when given 0' do
      it 'returns "0"' do
        expect(described_class.encode(0)).to eq('0')
      end
    end

    context 'when given a number greater than 0' do
      it 'returns the expected base62-encoded string' do
        cases.each do |string, number|
          expect(described_class.encode(number)).to eq(string)
        end
      end
    end
  end

  describe '.decode' do
    context 'when given "0"' do
      it 'returns 0' do
        expect(described_class.decode('0')).to eq(0)
      end
    end

    context 'when given a base62-encoded string' do
      it 'returns the expected number' do
        cases.each do |string, number|
          expect(described_class.decode(string)).to eq(number)
        end
      end
    end
  end
end