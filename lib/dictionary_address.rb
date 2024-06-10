# Dictionary of the open linear addressing method
# DICTIONARY[ <..>, <..>, <..>, ... , <..>]

# For more information:
# [ https://github.com/KristoMatsumoto/dictionaries ]
# Kristo Matsumoto, February 2024

# Stałe do obliczania współczynnika rehaszowania (N < D)
# Constants for calculating the ratio for rehashing (N < D)
# Константы для подсчета отношения для рехеширования (N < D)
N_NUM = 3
D_NUM = 4

# Dictionary of the open linear addressing
class DictionaryAddress
    attr_accessor :avg_filling

    # Class constructor
    def initialize( length = 3 )
        @arr = []           # Array of stored keys
        length.times do
            @arr << :empty
        end
        @size = 0
        @avg_filling ||= 0.75
    end

    # Static method for counting the number of comparison operations in called insert, find, delete methods
    def self.operations
        return @@operations ||= 0
    end

    # Method that returns the number of elements in the entire dictionary
    def size
        return @size
    end

    # Method to check if a cell is empty
    def empty?( _elem_ )
        @@operations += 1
        begin
            return _elem_ == :empty
        rescue TypeError
            return false
        end
    end

    # Method for checking if a cell is deleted
    def deleted?( _elem_ )
        @@operations += 1
        begin
            return _elem_ == :deleted
        rescue TypeError
            return false
        end
    end

    # Dictionary rehashing method
    def rehash( new_length )
        new_arr = []
        new_length.times do
            new_arr << :empty
        end
        @arr.each.with_index do | elem, index_of_elem |
            if (!empty?(@arr[index_of_elem]) && !deleted?(@arr[index_of_elem]))
                index = key(elem).hash % new_length
                while (!empty?(new_arr[index]))  # We do not check for the value :deleted, because it's a new array
                    @@operations += 1
                    index = (index + 1) % new_length
                end
                new_arr[index] = elem
            end
        end
        
        @arr = new_arr
    end

    # A method that returns the index of the element with key _key_ or, 
    # if there is none, the index of the first deleted or empty cell, or -1
    def scan_for( _key_ )
        index = _key_.hash % @arr.length
        start_index = index
        del_index = -1
        @@operations += 1
        while (!empty?(@arr[index]))
            if (deleted?(@arr[index]))
                if (del_index == -1) 
                    del_index = index
                end
            elsif (key(@arr[index]) == _key_)
                return index
            end
            @@operations += 1
            index = (index + 1) % @arr.length
            if (index == start_index) 
                return del_index
            end
        end
        @@operations += 1
        if (del_index != -1) 
            return del_index
        end
        return index
    end

    # Inserting an element: if successful, returns TRUE; if a duplicate is found, returns FALSE
    def insert( _element_ )
        @@operations = 1
        index = scan_for(key(_element_))
        if (index == -1)
            return false    # No area to push
        elsif (deleted?(@arr[index]) || empty?(@arr[index])) 
            @arr[index] = _element_
            @size += 1
            @@operations += 1
            if (@size > @arr.length * @avg_filling)
                rehash(@arr.length * 2)
            end
            return true
        end
        # @arr[index] = _element_
        return false    # Duplicate found
    end

    # Searching for an element: returns TRUE if successful; if the element is not found, returns FALSE
    def find( _key_ )
        @@operations = 1
        index = scan_for(_key_)
        if (index == -1 || empty?(@arr[index]) || deleted?(@arr[index]))
            # return nil
            return false
        end
        # return @arr[index]
        return true
    end

    # Removing an element: the element was successfully deleted - TRUE; if the element is not found, returns FALSE
    def delete( _key_ ) 
        @@operations = 1
        index = scan_for(_key_)
        if (!empty?(@arr[index]))
            if (deleted?(@arr[index])) 
                return false    # Element does not exist
            end
            @arr[index] = :deleted
            @size -= 1
            @@operations += 1
            if (@arr.length > 1) 
                @@operations += 1
                if (@size * 4 < @arr.length * @avg_filling)
                    rehash(@arr.length / 2)
                end 
            end
            return true
        end
        return false
    end

    # Conversion method to STRING type (for displaying and validating data)
    def to_s
        str = ""
        @arr.each.with_index do | elem, index |
            str += index.to_s + "\t"
            if (!empty?(@arr[index]) && !deleted?(@arr[index]))
                str += elem.to_s
            end
            str += "\n"
        end
        return str
    end

    # Method for changing the standard average of filling
    def avg_filling
        self.avg_filling
    end
end

# Function for obtaining the key in the case under consideration (the element is the key)
def key(element)
    return element
end