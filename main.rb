# frozen_string_literal: true

require_relative 'lib/tree'

numerical_array = [81, 68, 45, 49, 89, 65, 57, 30, 8, 94, 61, 99, 97, 10, 69]
# numerical_array = Array.new(15) { rand(1..100) }
sample_value = numerical_array[2]
p numerical_array
test_tree = Tree.new(numerical_array)
test_tree.pretty_print
p test_tree.include?(sample_value)
p test_tree.include?(101)
p test_tree.depth(sample_value)
p test_tree.height(sample_value)
test_tree.level_order { |node_data| print "#{node_data}, " }
puts "\n---"
test_tree.inorder { |node_data| print "#{node_data}, " }
puts "\n---"
test_tree.preorder { |node_data| print "#{node_data}, " }
puts "\n---"
test_tree.postorder { |node_data| print "#{node_data}, " }
puts test_tree.balanced?
test_tree.delete(sample_value)
test_tree.pretty_print
# test_tree.insert(101)
# test_tree.insert(102)
# test_tree.insert(103)
# puts test_tree.balanced?
# test_tree.rebalance
# puts test_tree.balanced?
# test_tree.pretty_print
# test_tree.level_order { |node_data| print "#{node_data}, " }
# puts "\n---"
# test_tree.inorder { |node_data| print "#{node_data}, " }
# puts "\n---"
# test_tree.preorder { |node_data| print "#{node_data}, " }
# puts "\n---"
# test_tree.postorder { |node_data| print "#{node_data}, " }
