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

def caesar_cipher(message, alpha_values, shift)
  encrypted_message_array = []
  shifted_encrypted_message_array_numbers = []
  shifted_encrypted_message_array_letters = []

  #split message into an array of letters
  message_to_array = message.split(//)

  #convert each letter in array to numbers
  message_to_array.each do |l|
    encrypted_message_array.push(alpha_values[l])
  end

  #add shift value to every number in array
  encrypted_message_array.each do |n|
    if n =~ /[0-5][0-9]/
      n_as_i = n.to_i
      if n_as_i < 27 && n_as_i + shift > 26
        n_as_i = n_as_i + shift - 26
      elsif n_as_i + shift > 52
        n_as_i = n_as_i + shift - 26
      elsif n_as_i > 0 && n_as_i + shift < 0
        n_as_i = n_as_i + shift + 26
      elsif n_as_i > 26 && n_as_i + shift < 27
        n_as_i = n_as_i + shift + 26
      else
        n_as_i = n_as_i + shift
      end

      shifted_encrypted_message_array_numbers.push(n_as_i.to_s.rjust(2, '0'))

    else
      shifted_encrypted_message_array_numbers.push(n)
    end
  end
  
  #convert shifted numbers array back to letters
  shifted_encrypted_message_array_numbers.each do |n|
    shifted_encrypted_message_array_letters.push(alpha_values.key(n.to_s))
  end

  #join the array of shifted letters for the final output  
  p shifted_encrypted_message_array_letters.join
end

#the program

make_alpha_values_hash(characters, alpha_values)

puts "Please input message to encrypt/decrypt"
message = gets.chomp
puts "Please input shift value"
shift = gets.chomp.to_i
while shift === 0 do
  puts "Please input a number greater than or less than 0"
  shift = gets.chomp.to_i
end
shift = shift + 26

shift = shift % 26 

caesar_cipher(message, alpha_values, shift)
