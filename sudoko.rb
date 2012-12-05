require 'minitest/autorun'
#main class
class Sudoko
	attr_accessor :field
	def initialize()
		@field = Field.new()  
	end

	def print_sudoko
		self.field.blocks.each {|each_block| each_block.print) }
	end	
end

#fields
class Field
	attr_accessor :blocks, :number_of_squares, :number_of_blocks
	def initialize(number_of_squares = 81, number_of_blocks = 9)
		@number_of_squares = number_of_squares
		@number_of_blocks = number_of_blocks
		self.create_blocks 
	end

	def squares_per_block
		return (@number_of_squares / @number_of_blocks)
	end

	def create_blocks
		@blocks = Array.new(@number_of_blocks)
		@number_of_blocks.times	{|idx| @blocks[idx] = Block.new(idx, self.squares_per_block) } 
	end


end

#blocks
class Block 
	attr_accessor :squares, :field, :number_of_squares
	def initialize(block_number, number_of_squares = 9)
		@number_of_squares = number_of_squares
		self.create_squares
	end

	def identity 
		return 0
	end
	def create_squares
		@squares = Array.new(number_of_squares)	
		@number_of_squares.times {|idx| @squares[idx] = Square.new(idx+1) }
	end

end

#squares
class Square 
	attr_accessor :number, :block
	def initialize(number)
		@number = number
	end
	def to_s 
		"#{@number}"
	end
end










#tests
class TestSudoko < MiniTest::Unit::TestCase
	def test_setup
		sud = Sudoko.new()
	end
	def test_field
		sud = Sudoko.new()
		refute_nil sud.field
	end
	def test_field_size
		sud = Sudoko.new()
		field = sud.field
		assert(field.number_of_squares = (9*9))
	end
	def test_blocks
		sud = Sudoko.new()
		field = sud.field
		refute_nil sud.field
		field.blocks.each {|each| assert(each.field = field)}
	end
	def test_block_squares_ratio
		sud = Sudoko.new()
		field = sud.field
		assert(field.number_of_squares = (field.number_of_blocks*field.squares_per_block))
	end
	def test_block_identity
		sud = Sudoko.new()
		field = sud.field
		field.blocks.each {|each| refute_nil(each.identity)} 
	end

	def test_squares
		sud = Sudoko.new()
		field = sud.field
		field.blocks.each do |each| 
			each.squares.each do |eac| 
				assert(eac.block = each)
				assert(eac.number > 0)
				assert(eac.number <= field.squares_per_block)
			end
		end
	end

	def test_print
		sud = Sudoko.new()
		sud.print_sudoko
	end	
end