# Dictionaries
 
This is a library containing two types of dictionaries: a *chain method dictionary* and a *linear addressing dictionary*. They support operations such as **adding**, **searching**, and **deleting** elements, and their expected time complexity is O(1). This will help you optimize complex algorithms in your projects, where searching among a large number of elements is used.
Dictionaries also support **rehashing** - changing the size depending on the percentage of content.

---

### Connecting

To use these libraries, connect them in your project using
```ruby
require "#{path}/lib/dictionary_chain.rb"       # Dictionary of the chain method
require "#{path}/lib/dictionary_address.rb"     # Dictionary of the open linear addressing method
```
or
```ruby
require_relative "#{short_path}/lib/dictionary_chain.rb"        # Dictionary of the chain method
require_relative "#{short_path}/lib/dictionary_address.rb"      # Dictionary of the open linear addressing method
```
Here `path` is your absolute installation path, `short_path` is your installation path relative to the project file where the connection is made.

---

### Usage

To create a class object use
```ruby
dict_c = DictionaryChain.new        # for dictionary of the chain method
dict_c1 = DictionaryChain.new 10    # for dictionary of the chain method with start size = 10
dict_a = DictionaryAddress.new      # for dictionary of the open linear addressing method
dict_a1 = DictionaryAddress.new 10  # for dictionary of the open linear addressing method with start size = 10
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

To **insert** an element use:
```ruby
dict_c.insert(element)
dict_a.insert(element)
```

And to **delete** use key of element you need:
```ruby
dict_c.delete(element.key)
dict_a.delete(element.key)
```

To **find** use:
```ruby
# finding by ELEMENT KEY
dict_c.find(element.key)      
dict_a.find(element.key)     
```

`avg_elements` is the average of the number of elements in each cell of the chained method dictionary. By default it is 4, but you can change it. It also returns the current value.
`avg_filling` this is a similar value that regulates the percentage of the open addressing dictionary. The default value is 0.75 (or 75%). You can also change it in the limit (0, 1).
```ruby
dict_c.avg_elements         # => 4
dict_c.avg_elements = 7     # => 7
dict_c.avg_elements         # => 7

dict_a.avg_filling          # => 0.75
dict_a.avg_filling = 0.5    # => 0.5
dict_a.avg_filling          # => 0.5
```
**Important**: if this value is changed, rehashing can only occur on the next call to **insert** or **delete**.


For debugging, you can also output the dictionary to the console in formatted form:
```ruby
puts dict_c             # =>
# 0
# 1       0 1 2
# 2       3 4
puts dict_c.inspect     # =>
# #<DictionaryChain:0x0000000000000000 @arr=[[], [0, 1, 2], [3, 4]], @size=5, @avg_elements=4>

puts dict_a             # =>
# 0       1
# 1       4
# 2       0
# 3       3
# 4
# 5
# 6
# 7
# 8
# 9       2
# 10
# 11
puts dict_a.inspect     # =>
# #<DictionaryAddress:0x0000000000000000 @arr=[4, :empty, 3, :empty, :empty, 1, :empty, 0, :empty, :empty, :empty, 2], @size=5, @avg_filling=0.75>
```

After each operation, you can also find out the number of comparisons that were performed for the last method called:

```ruby
DictionaryChain.operations      # => number
# or
DictionaryAddress.operations    # => number
```