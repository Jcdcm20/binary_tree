class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array, start = 0, endpoint = array.length - 1)
    mid = (start + endpoint) / 2
    
    return nil if start > endpoint
    root = Node.new(array[mid])

    root.left = build_tree(array, start, mid - 1)
    root.right = build_tree(array, mid + 1, endpoint)

    root
  end

  def insert(value, current = @root)
    if (current.nil?) 
      return Node.new(value)
    else
      if (current.data == value)
        return current
      elsif (current.data < value)
        current.right = insert(value, current.right)
      else
        current.left = insert(value, current.left)
      end
    end
      return current
  end

  def delete(value, current = @root)
    if (current.nil?)
      return root
    else
      if (current.data > value) 
        current.left = delete(value, current.left)
        return current
      elsif (current.data < value)
        current.right = delete(value, current.right)
        return current
      end

      if (current.left.nil?)
        temp = current.right
        return temp
      elsif(current.right.nil?)
        temp = current.left
        return temp
      else
        parentNode = current
        closest = current.right
        until closest.left.nil? do
          parentNode = closest
          closest = closest.left
        end

        if parentNode != current
          parentNode.left = closest.right
        else
          parentNode.right = closest.right
        end

        current.data = parentNode.data
        
        return current
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

