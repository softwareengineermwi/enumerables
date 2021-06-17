# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require './enumerable'

describe Enumerable do
  array = %w[Mwila Elisha Taro Chawanzi Alick Munsa]
  hash = { min: 1, max: 10 }

  describe 'my_each' do
    context 'if !block' do
      it 'returns enum' do
        expect(arr.my_each).to be_an Enumerator
      end
    end

    context 'if block' do
      context 'when self is an array' do
        it 'yields item' do
          arr = array.my_each { |friend| friend }
          expect(arr).to eq(%w[Mwila Elisha Taro Chawanzi Alick Munsa])
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
            expect(arr).to eq(%w[Alick Munsa])
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
          expect(arr).to eq(['0: Alick', '1: Munsa'])
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
