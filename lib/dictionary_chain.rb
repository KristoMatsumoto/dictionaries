# Dictionary of the chain method
# DICTIONARY[ 
#   [],     # => elements whose shortened key hash returns 0
#   [],     # => elements whose shortened key hash returns 1
#   [],     # => elements whose shortened key hash returns 2
#   ...
#   []      # => elements whose shortened key hash returns @length - 1
# ]

# For more information:
# [ https://github.com/KristoMatsumoto/dictionaries ]
# Kristo Matsumoto, February 2024


class DictionaryChain
    attr_accessor :avg_elements

    # Class constructor
    def initialize( length = 3 )
        @arr = []           # Array of stored keys
        length.times do
            @arr << []
        end
        @size = 0
        @avg_elements ||= 4
    end

    # Static method for counting the number of comparison operations in called insert, find, delete methods
    def self.operations
        return @@operations ||= 0
    end

    # Method that returns the number of elements in the entire dictionary
    def size
        return @size
    end

    # Hash function
    def h( element )
        return key(element).hash % @arr.length
    end

    # Dictionary rehashing method
    def rehash( new_length )
        new_arr = []
        new_length.times do
            new_arr << []
        end

        @arr.each do | arr_of_elems |
            arr_of_elems.each do | elem | 
                new_arr[key(elem).hash % new_length] << elem
                # new_arr[key(elem).hash % new_length][new_arr.length] = elem
            end
        end

        @arr = new_arr
    end

    # Inserting an element: if successful, returns TRUE; if a duplicate is found, returns FALSE
    def insert( _element_ )
        @@operations = 1
        if (find_from_key(key(_element_)))
            return false
        end
        @arr[h(_element_)] << _element_
        @size += 1
        @@operations += 1
        if (@arr.length * @avg_elements < @size)
            rehash(@arr.length * 2)
        end
        return true
    end

    # Searching for an element: returns TRUE if successful; if the element is not found, returns FALSE
    def find( _element_ )
        @@operations = 0
        @arr[h(_element_)].each do | elem |
            @@operations += 1
            if (elem == _element_)
                return true
            end
        end
        return false
    end

    def find_from_key( _key_ )
        @arr[_key_.hash % @arr.length].each do | elem |
            @@operations += 1
            if (key(elem) == _key_)
                return true
            end
        end
        return false
    end
    
    # Removing an element: the element was successfully deleted - TRUE; if the element is not found, returns FALSE
    def delete( _key_ )
        @@operations = 0
        @arr[_key_.hash % @arr.length].each.with_index do | elem, index |
            @@operations += 1
            if (key(elem) == _key_)
                @arr[_key_.hash % @arr.length].delete_at(index)
                @size -= 1
                @@operations += 1
                if (@arr.length > 1)
                    @@operations += 1
                    if (@arr.length * @avg_elements > @size * 4)
                        rehash(@arr.length / 2)
                    end
                end
                return true
            end
        end
        return false
    end

    # Conversion method to STRING type (for displaying and validating data)
    def to_s
        str = ""
        @arr.each.with_index do | arr_of_elems, index |
            str += index.to_s + "\t"
            arr_of_elems.each do | elem |
                str += elem.to_s + " "
            end
            str += "\n"
        end
        return str
    end

    # Method for changing the standard average of elements per cell
    def avg_elements
        self.avg_elements
    end
end

# Function for obtaining the key
def key(element)
    return element
end