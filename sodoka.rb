require 'minitest/autorun'

class Sudoka
  def field
    @field ||= Field.new
  end
end

class Field
  attr_accessor :blocks

  def initialize
    self.create_blocks
  end

  def nr_of_blocks
    9
  end

  def number_of_squares
    self.blocks.inject(0) {|sum, block| sum += block.squares.count }
  end

  def create_blocks
    self.blocks = []
    nr_of_blocks.times do |idx|
      self.blocks << Block.new(idx, self)
    end
  end
end

class Block
  attr_accessor :index, :field, :squares

  def initialize index, field
    self.index = index
    self.field = field
    self.create_squares
  end

  def nr_of_squares
    9
  end

  def create_squares
    self.squares = []
    given_values = (1..9).to_a.shuffle
    nr_of_squares.times do
      self.squares << Square.new(given_values.shift, self)
    end
  end

  # TODO: use it
  def identity
    0
  end
end

class Square
  attr_accessor :number, :block
  def initialize number, block
    self.number = number
    self.block = block
  end

  def to_s
    number
  end
end

class TestSudoko < MiniTest::Unit::TestCase
  def test_setup
    sud = Sudoka.new
  end
  def test_field
    sud = Sudoka.new
    refute_nil sud.field
  end
  def test_field_size
    sud = Sudoka.new
    field = sud.field
    assert_equal(field.number_of_squares, (9*9))
  end

  # TODO Check is useful
  # def test_block_squares_ratio
  #   sud = Sudoka.new
  #   field = sud.field
  #   assert_equal(field.number_of_squares, (field.number_of_blocks*field.squares_per_block))
  # end
  def test_block_identity
    sud = Sudoka.new
    field = sud.field
    field.blocks.each {|block| refute_nil(block.identity)}
  end

  def test_squares
    sud = Sudoka.new
    field = sud.field
    field.blocks.each do |block|
      block.squares.each do |square|
        assert_equal(square.block, block)
        assert( (1..9).to_a.include?(square.number) )
      end
    end
  end

  def test_print
  # sud = Sudoko.new
  # sud.print_sudoko
  end
end