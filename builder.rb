require "json"

@scrabble_scores = {
  'a' => 1, 'b' => 3, 'c' => 3, 'd' => 2, 'e' => 1, 'f' => 4, 'g' => 2,
  'h' => 4, 'i' => 1, 'j' => 8, 'k' => 5, 'l' => 1, 'm' => 3, 'n' => 1,
  'o' => 1, 'p' => 3, 'q' => 10, 'r' => 1, 's' => 1, 't' => 1, 'u' => 1,
  'v' => 4, 'w' => 4, 'x' => 8, 'y' => 4, 'z' => 10
}

def self.calculate_word(word) 
  sum = 0

  word.each_char do |char|
    value = @scrabble_scores[char]
    
    sum += value
  end
  sum
end


dictionary = File.readlines('twl06.txt').map(&:strip)

entries = Hash.new
dictionary.map do |word|
  entries.store(word, calculate_word(word))
end

json_string = JSON.generate(entries)   

file_path = "data.json"
File.open(file_path, "w") do |file|
  file.write(json_string)
end
