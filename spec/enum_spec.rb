require './enumerable'

describe Enumerable do
  array = %w[Mwila Elisha Taro Chawanzi Alick]
  hash = { min: 1, max: 10 }

  describe 'my_each' do
    context 'if !block' do
      it 'returns enum' do
        expect(array.my_each).to be_an(Enumerator)
      end
    end

    context 'if block' do
      context 'when self is an array' do
        it 'yields item' do
          arr = array.my_each { |friend| friend }
          expect(arr).to eq(%w[Mwila Elisha Taro Chawanzi Alick])
        end

        context 'when self is a hash' do
          it 'yields item' do
            result = []
            hash.my_each { |key, value| result.push("k: #{key}, v: #{value}") }
            expect(result).to eq(['k: min, v: 1', 'k: max, v: 10'])
          end
        end

        context 'when self is a range' do
          it 'yields items in that range' do
            arr = array[3..-1].my_each { |item| item }
            expect(arr).to eq(%w[Chawanzi Alick])
          end
        end
      end
    end
  end

  describe 'my_each_with_index' do
    context 'if !block' do
      it 'returns enum' do
        expect(array.my_each_with_index).to be_an Enumerator
      end
    end

    context 'if block' do
      context 'when self is an array' do
        it 'yields index' do
          arr = []
          array.my_each_with_index { |_item, index| arr.push(index) }
          expect(arr).to eq([0, 1, 2, 3, 4])
        end
      end
      context 'when self is an hash' do
        it 'yields item with index' do
          arr = []
          array.my_each_with_index { |friend, index| arr.push("#{index}: #{friend}") if index.odd? }
          expect(arr).to eq(['1: Elisha', '3: Chawanzi'])
        end
      end
      context 'when self is a range' do
        it 'yields items in that range' do
          arr = []
          array[3..-1].my_each_with_index { |item, index| arr.push("#{index}: #{item}") }
          expect(arr).to eq(['0: Chawanzi', '1: Alick'])
        end
      end
    end
  end

  describe 'my_select' do
    context 'if !block' do
      it 'returns enum' do
        expect(array.my_select).to be_an Enumerator
      end
    end

    context 'if block given' do
      context 'when self is an array' do
        it 'yields selected items' do
          arr = []
          array.my_select { |friend| arr.push(friend) if friend != 'Brian' }
          expect(arr).to eq(%w[Sharon Leo Leila Arun])
        end
      end

      context 'when self is a hash' do
        it 'yields selected items with their index' do
          result = []
          hash.my_select { |k, v| result.push(k, v) if v > 4 }
          expect(result).to eq([:max, 5])
        end
      end

      context 'when self is a range' do
        it 'yields selected items within that range' do
          arr = []
          array[3..-1].my_select { |friend| arr.push(friend) if friend != 'Brian' }
          expect(arr).to eq(['Arun'])
        end
      end
    end
  end
end
