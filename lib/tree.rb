# frozen_string_literal: true

require_relative 'node'

# Represents a binary search tree data structure.
class Tree
  def initialize(numeric_array)
    @root = build_tree(numeric_array)
  end

  def include?(value)
    current_node = @root

    until current_node.nil?
      if value == current_node.data
        return true
      elsif value < current_node.data
        current_node = current_node.left
      elsif value > current_node.data
        current_node = current_node.right
      end
    end

    false
  end

  def insert(value)
    return if include?(value)

    if @root.nil?
      @root = Node.new(value)
      return
    end

    parent_node = @root

    loop do
      if value < parent_node.data && !parent_node.left.nil?
        parent_node = parent_node.left
      elsif value > parent_node.data && !parent_node.right.nil?
        parent_node = parent_node.right
      elsif value < parent_node.data
        parent_node.left = Node.new(value)
        return
      else
        parent_node.right = Node.new(value)
        return
      end
    end
  end

  def delete(value); end

  def level_order; end

  def inorder; end

  def preorder; end

  def postorder; end

  def height(value)
  end

  def depth(value)
    depth = 0
    current_node = @root

    until current_node.nil?
      if value == current_node.data
        return depth
      elsif value < current_node.data
        current_node = current_node.left
      elsif value > current_node.data
        current_node = current_node.right
      end

      depth += 1
    end

    nil
  end

  def balanced?; end

  def rebalance; end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  private

  def build_tree(numeric_array)
    sorted_unique_array = numeric_array.sort.uniq
    build_tree_recursive(sorted_unique_array, 0, numeric_array.size - 1)
  end

  def build_tree_recursive(numeric_array, first_int, last_int)
    return if first_int > last_int

    mid_int = (first_int + ((last_int - first_int) / 2)).to_i

    root = Node.new(numeric_array[mid_int])
    root.left = build_tree_recursive(numeric_array, first_int, mid_int - 1)
    root.right = build_tree_recursive(numeric_array, mid_int + 1, last_int)

    root
  end
end
