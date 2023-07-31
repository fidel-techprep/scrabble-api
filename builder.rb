# Dictionary builder for future updates
# word_list.txt => JSON file with words and their values

require "json"

puts("Enter dictionary filename:")

dictionary_file = gets

# Letter scores in Scrabble
@scrabble_scores = {
  'a' => 1, 'b' => 3, 'c' => 3, 'd' => 2, 'e' => 1, 'f' => 4, 'g' => 2,
  'h' => 4, 'i' => 1, 'j' => 8, 'k' => 5, 'l' => 1, 'm' => 3, 'n' => 1,
  'o' => 1, 'p' => 3, 'q' => 10, 'r' => 1, 's' => 1, 't' => 1, 'u' => 1,
  'v' => 4, 'w' => 4, 'x' => 8, 'y' => 4, 'z' => 10
}

# Calculate each word's score
def self.calculate_word(word) 
  sum = 0

  word.each_char do |char|
    value = @scrabble_scores[char]
    sum += value
  end

  sum
end

# Load dictionary into memory
dictionary = File.readlines(dictionary_file).map(&:strip)

# Create hash to hold words and scores
entries = Hash.new

# Load words and scores into hash
dictionary.map do |word|
  entries.store(word, calculate_word(word))
end

# Generate JSON file
json_string = JSON.generate(entries)   

file_path = "data.json"

# Write file to disk
File.open(file_path, "w") do |file|
  file.write(json_string)
end
