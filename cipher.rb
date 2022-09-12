#variables
characters = ('a'..'z').to_a + ('A'..'Z').to_a


alpha_values = {
  " " => "60",
  "!" => "61",
  "?" => "62",
  "." => "63",
  "," => "64"
}



#methods
def make_alpha_values_hash(characters, alpha_values)
  characters.each do |l|
    character_index = characters.index(l)
    index_value = character_index + 1
    alpha_values[l] = index_value.to_s.rjust(2, '0')
  end
end

def encrypt_message(message, alpha_values, shift)
  encrypted_message_array = []
  shifted_encrypted_message_array_numbers = []
  shifted_encrypted_message_array_letters = []
  
  puts "Message: #{message}, Shift: #{shift}"

  #split message into an array of letters
  message_to_array = message.split(//)
  puts "split message into an array of letters"
  p message_to_array

  #convert each letter in array to numbers
  message_to_array.each do |l|
    encrypted_message_array.push(alpha_values[l])
  end

  puts "convert each letter in array to numbers"
  p encrypted_message_array

  #add shift value to every number in array
  encrypted_message_array.each do |n|
    if n =~ /[0-5][0-9]/
      n_as_i = n.to_i
      if n_as_i < 27 && n_as_i + shift > 26
        n_as_i = n_as_i + shift - 26
        puts "Case 1: #{n_as_i}"
      elsif n_as_i + shift > 52
        n_as_i = n_as_i + shift - 26
        puts "Case 2: #{n_as_i}"
      elsif n_as_i > 0 && n_as_i + shift < 0
        n_as_i = n_as_i + shift + 26
        puts "Case 3: #{n_as_i}"
      elsif n_as_i > 26 && n_as_i + shift < 27
        n_as_i = n_as_i + shift + 26
        puts "Case 4: #{n_as_i}"
      else
        n_as_i = n_as_i + shift
        puts "Case 5: #{n_as_i}"
      end

      shifted_encrypted_message_array_numbers.push(n_as_i.to_s.rjust(2, '0'))
      puts "Letter"
    else
      shifted_encrypted_message_array_numbers.push(n)
      puts "Symbol"
    end
  end

  puts "add shift value to every number in array"
  p shifted_encrypted_message_array_numbers
  
  #convert shifted numbers array back to letters
  shifted_encrypted_message_array_numbers.each do |n|
    shifted_encrypted_message_array_letters.push(alpha_values.key(n.to_s))
  end

  puts "convert shifted numbers array back to letters"
  p shifted_encrypted_message_array_letters

  #join the array of shifted letters for the final output
  puts "join the array of shifted letters for the final output"
  p shifted_encrypted_message_array_letters.join
end

#the program
p characters
make_alpha_values_hash(characters, alpha_values)
p alpha_values
puts "Please input message to encrypt/decrypt"
message = gets.chomp
puts "Please input shift value"
shift = gets.chomp.to_i
while shift === 0 do
  puts "Please input a number greater than or less than 0"
  shift = gets.chomp.to_i
end
shift = shift + 26
puts "shift + 26: #{shift}"
shift = shift % 26 
puts shift
encrypt_message(message, alpha_values, shift)
