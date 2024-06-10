# dictionaries
 
This is a library containing two types of dictionaries: a *chain method dictionary* and a *linear addressing dictionary*. They support operations such as **adding**, **searching**, and **deleting** elements, and their expected time complexity is O(1). This will help you optimize complex algorithms in your projects, where searching among a large number of elements is used.
Dictionaries also support **rehashing** - changing the size depending on the percentage of content.

---

### Connecting

To use these libraries, connect them in your project using
`require "#{path}/lib/my_library"`
or
`require_relative "#{short_path}/lib/my_library"`
Here `path` is your absolute installation path, `short_path` is your installation path relative to the project file where the connection is made.

---

### Usage

To create a class object use
```ruby
dict_c1 = DictionaryChain.new       # for dictionary of the chain method
dict_c2 = DictionaryChain.new 10    # for dictionary of the chain method with start size = 10
dict_a1 = DictionaryAdres.new       # for dictionary of the open linear addressing method
dict_a2 = DictionaryAdres.new 10    # for dictionary of the open linear addressing method with start size = 10
```

These dictionaries work on key-value objects. Regular values ​​get their key using the following method:
```ruby
def key(element)
    return element
end
```
Reassign it if you already have key-value pair objects created, for example:
```ruby
def key(element)
    return element.key
end
```

The add, search and delete methods all return `true` on success and `false` on failure.

To insert an element use:
```ruby
dict_c1.insert(element)
```

And to delete use key of element you need:
```ruby
dict_c1.delete(element.key)
```

To search for elements use:
```ruby
dict_c1.find(element)                   # => finding by ELEMENT / ELEMENT VALUE
dict_c1.find_from_key(element.key)      # => finding by ELEMENT KEY
```

`avg_elements` is the average of the number of elements in each cell of the chained method dictionary. By default it is 4, but you can change it. It also returns the current value.
```ruby
dict_c1.avg_elements        # => 4
dict_c1.avg_elements = 7    # => 7
dict_c1.avg_elements        # => 7
```
**Important**: if this value is changed, rehashing can only occur on the next call to **insert** or **delete**.


For debugging, you can also output the dictionary to the console in formatted form:
```ruby
puts dict_c1            # =>
# 0
# 1       0 1 2
# 2       3 4
puts dict_c1.inspect    # =>
# #<DictionaryChain:0x0000000000000000 @arr=[[], [0, 1, 2], [3, 4]], @size=5, @avg_elements=4>
```