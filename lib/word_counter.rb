class WordCounter

  def initialize
    @counts = Hash.new(0)
  end

  # Count the words in a piece of content, only count if the word is 4 of more characters
  def count(content)
    words  = content.scan(/\w+/)
    puts "Number of words #{words.length}"
    words.each do |word|
      # Only count words if 4 or more characters
      if word.length > 3
        @counts[word.downcase] += 1
      end
    end
  end

  # Write the sorted output to a file
  def write
    puts "Writing counts in decreasing order "
    puts @counts.length
    open("output/counts-decreasing-ruby", "w") do |out|
      @counts.sort { |a, b| b[1] <=> a[1] }.each do |pair|
        # Only write if the word appears more than once
        if pair[1] > 1
          out << "#{pair[0]}\t#{pair[1]}\n"
        end
      end
    end
    #puts "Writing counts in alphabetical order"
    #open("counts-alphabetical-ruby", "w") do |out|
    #  @counts.sort { |a, b| a[0] <=> b[0] }.each { |pair| out << "#{pair[0]}\t#{pair[1]}\n" } end
  end
end