require_relative 'lib/tree'

test_tree = Tree.new(Array.new(15) { rand(1..100) })
test_tree.pretty_print
p test_tree.include?(12)