# frozen_string_literal: true

# Represents a single node within a binary search tree.
class Node
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end
