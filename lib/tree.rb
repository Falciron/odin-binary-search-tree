# frozen_string_literal: true

require_relative 'node'

# Represents a binary search tree data structure.
class Tree
  def initialize(numeric_array)
    @root = build_tree(numeric_array)
  end

  def include?(value)
    !find_node_with_value(value).nil?
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

  def level_order
    return to_enum(:level_order) unless block_given?

    nodes_to_visit = [@root]
    until nodes_to_visit.empty?
      current_numeric = nodes_to_visit.shift
      yield current_numeric.data

      nodes_to_visit << current_numeric.left unless current_numeric.left.nil?
      nodes_to_visit << current_numeric.right unless current_numeric.right.nil?
    end

    self
  end

  def inorder(&block)
    return to_enum(:inorder) unless block_given?

    inorder_recursive(@root, &block)

    self
  end

  def preorder(&block)
    return to_enum(:preorder) unless block_given?

    preorder_recursive(@root, &block)

    self
  end

  def postorder(&block)
    return to_enum(:preorder) unless block_given?

    postorder_recursive(@root, &block)

    self
  end

  def height(value)
    node_with_value = find_node_with_value(value)
    return if node_with_value.nil?

    node_height_recursive(node_with_value, 0)
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
    build_tree_recursive(sorted_unique_array, 0, sorted_unique_array.size - 1)
  end

  def build_tree_recursive(numeric_array, first_numeric, last_numeric)
    return if first_numeric > last_numeric

    mid_numeric = (first_numeric + ((last_numeric - first_numeric) / 2)).to_i
    root = Node.new(numeric_array[mid_numeric])

    root.left = build_tree_recursive(numeric_array, first_numeric, mid_numeric - 1)
    root.right = build_tree_recursive(numeric_array, mid_numeric + 1, last_numeric)

    root
  end

  def inorder_recursive(root_node, &block)
    inorder_recursive(root_node.left, &block) unless root_node.left.nil?
    yield root_node.data
    inorder_recursive(root_node.right, &block) unless root_node.right.nil?
  end

  def preorder_recursive(root_node, &block)
    yield root_node.data
    preorder_recursive(root_node.left, &block) unless root_node.left.nil?
    preorder_recursive(root_node.right, &block) unless root_node.right.nil?
  end

  def postorder_recursive(root_node, &block)
    postorder_recursive(root_node.left, &block) unless root_node.left.nil?
    postorder_recursive(root_node.right, &block) unless root_node.right.nil?
    yield root_node.data
  end

  def node_height_recursive(root_node, maximum_height)
    left_height = root_node.left.nil? ? 0 : 1 + node_height_recursive(root_node.left, maximum_height)
    right_height = root_node.right.nil? ? 0 : 1 + node_height_recursive(root_node.right, maximum_height)
    [left_height, right_height].max
  end

  def find_node_with_value(value)
    current_node = @root

    until current_node.nil?
      if value == current_node.data
        return current_node
      elsif value < current_node.data
        current_node = current_node.left
      elsif value > current_node.data
        current_node = current_node.right
      end
    end

    nil
  end
end
