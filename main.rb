# frozen_string_literal: true

require_relative 'lib/tree'

numerical_array = Array.new(15) { rand(1..100) }
test_tree = Tree.new(numerical_array)
test_tree.pretty_print
test_tree.level_order { |node_data| print "#{node_data} " }
puts "\n----"
test_tree.preorder { |node_data| print "#{node_data} " }
puts "\n----"
test_tree.postorder { |node_data| print "#{node_data} " }
puts "\n----"
test_tree.inorder { |node_data| print "#{node_data} " }
puts "\n\nInitial tree is balanced: #{test_tree.balanced?}\n\n"
[101, 102, 103].each { |value| test_tree.insert(value) }
test_tree.pretty_print
puts "\nModified tree is balanced: #{test_tree.balanced?}\n\n"
test_tree.rebalance
test_tree.pretty_print
puts "\nRebalanced tree is balanced: #{test_tree.balanced?}\n\n"
test_tree.level_order { |node_data| print "#{node_data} " }
puts "\n----"
test_tree.preorder { |node_data| print "#{node_data} " }
puts "\n----"
test_tree.postorder { |node_data| print "#{node_data} " }
puts "\n----"
test_tree.inorder { |node_data| print "#{node_data} " }
