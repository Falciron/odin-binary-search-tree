# frozen_string_literal: true

require_relative 'node'
require_relative 'recursive_tree_methods'

# Represents a binary search tree data structure.
class Tree
  include RecursiveTreeMethods

  def initialize(numeric_array)
    @root = build_tree(numeric_array)
  end

  def include?(value)
    !find_node_with_value_recursive(@root, value).nil?
  end

  def insert(value)
    if @root.nil?
      @root = Node.new(value)
      return
    end

    insert_recursive(@root, value)
  end

  def delete(value)
    delete_recursive(@root, value)
  end

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
    node_with_value = find_node_with_value_recursive(@root, value)
    return if node_with_value.nil?

    node_height_recursive(node_with_value, 0)
  end

  def depth(value)
    depth_recursive(@root, value, 0)
  end

  def balanced?
    return true if @root.nil?

    balanced_recursive(@root)
  end

  def rebalance
    @root = build_tree(inorder)
  end

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

  def get_successor_node(current_node)
    current_node = current_node.right
    current_node = current_node.left until current_node.nil? || current_node.left.nil?
    current_node
  end
end
