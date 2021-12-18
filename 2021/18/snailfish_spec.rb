require 'rspec'
require_relative 'snailfish'

describe Snailfish do
  describe 'parsing' do
    it 'parses a simple pair' do
      input = Snailfish.parse <<~END
        [1,2]
      END

      input.should eq [n(1, 2)]
    end

    it 'parses a left nested pair' do
      input = Snailfish.parse <<~END
        [[1,2],3]
      END

      input.should eq [n(n(1, 2), 3)]
    end

    it 'parses a right nested pair' do
      input = Snailfish.parse <<~END
        [9,[8,7]]
      END

      input.should eq [n(9, n(8, 7))]
    end

    it 'parses two nested pairs' do
      input = Snailfish.parse <<~END
        [[1,9],[8,5]]
      END

      input.should eq [n(n(1, 9), n(8, 5))]
    end

    it 'parses a more complex example' do
      input = Snailfish.parse <<~END
        [[[[1,2],[3,4]],[[5,6],[7,8]]],9]
      END
      p input.first.height

      input.should eq [n(
        n(n(n(1,2),n(3,4)),n(n(5,6),n(7,8))),
        9
      )]
    end
  end

  describe 'addition' do
    it 'adds two' do
      result = n(1,2) + n(n(3,4),5)
      result.should eq n(n(1,2), n(n(3,4),5))
    end
  end

  def n(left, right)
    Snailfish::Pair.new left, right
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = %i(should expect)
  end
end
