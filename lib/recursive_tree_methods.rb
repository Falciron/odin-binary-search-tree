# frozen_string_literal: true

# Includes recursive methods for build, modifying, balancing, and outputting a binary search tree.
module RecursiveTreeMethods
  def build_tree_recursive(numeric_array, first_numeric, last_numeric)
    return if first_numeric > last_numeric

    mid_numeric = (first_numeric + ((last_numeric - first_numeric) / 2)).to_i
    root = Node.new(numeric_array[mid_numeric])

    root.left = build_tree_recursive(numeric_array, first_numeric, mid_numeric - 1)
    root.right = build_tree_recursive(numeric_array, mid_numeric + 1, last_numeric)

    root
  end

  def delete_recursive(root_node, value)
    return root_node if root_node.nil?

    if root_node.data > value
      root_node.left = delete_recursive(root_node.left, value)
    elsif root_node.data < value
      root_node.right = delete_recursive(root_node.right, value)
    else
      return root_node.right if root_node.left.nil?
      return root_node.left if root_node.right.nil?

      successor_node = get_successor_node(root_node)
      root_node.data = successor_node.data
      root_node.right = delete_recursive(root_node.right, successor_node.data)
    end

    root_node
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

  def balanced_recursive(root_node)
    return true if root_node.left.nil? && root_node.right.nil?

    node_balanced = (node_height_recursive(@root.left, 0) - node_height_recursive(@root.right, 0)).abs <= 1
    left_balanced = root_node.left.nil? || balanced_recursive(root_node.left)
    right_balanced = root_node.right.nil? || balanced_recursive(root_node.right)
    node_balanced && left_balanced && right_balanced
  end
end
