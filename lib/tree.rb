class Tree
  def initialize(numeric_array)
    @root = build_tree(numeric_array)
  end

  private

  def build_tree(numeric_array)
    numeric_array.each { |numeric_value| insert(numeric_value) }
    @root
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end
end