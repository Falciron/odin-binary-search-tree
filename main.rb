# frozen_string_literal: true

require_relative 'lib/tree'

numerical_array = Array.new(15) { rand(1..100) }
p numerical_array
test_tree = Tree.new(numerical_array)
test_tree.pretty_print
p test_tree.include?(12)
p test_tree.depth(numerical_array[2])
test_tree.level_order { |node| print "#{node.data}, " }
