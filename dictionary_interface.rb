require "./lib/dictionary"
require 'pry'

@edit_word = []

def main_menu
  puts ""
  puts 'Welcome to the Ruby Dictionary'
  puts '--------------'
  puts "Press 'A' to add a new word to the dictionary"
  puts "Press 'S' to search for a term in your dictionary"
  puts "Press 'L' to show all the words you have added"
  puts "Press 'D' to display words with definitions"
  puts "Press 'X' to exit"

  main_choice = gets.chomp.downcase

  if main_choice == 'a'
    new_term
  elsif main_choice == 'l'
    show_words
  elsif main_choice == 's'
    search
  elsif main_choice == 'x'
    puts "Thanks for using Ruby Dictionary, Good-Bye!"
  elsif main_choice == 'd'
    show_definitions
    edit_menu
  else
    puts "Invalid choice please try something else."
    main_menu
  end
end

def new_term
  puts "Enter a new word:"
  new_word = gets.chomp
  puts "Enter the definition:"
  new_definition = gets.chomp

  new_entry = Term.create(new_word, new_definition)
  main_menu
end

def show_words
  Term.all.each { |term| puts term.word }
  puts "Press 'E' if you would like to edit an entry"
  puts "Press 'M' to return to Main Menu"
  edit_choice = gets.chomp.downcase
  if edit_choice == 'e'
    edit_menu
  elsif edit_choice == 'm'
    main_menu
  end
end

def show_definitions
  puts "Entries: "
  Term.all.each do |term|
    word_holder = term.word_array.each { |x| puts x }
    puts "#{word_holder}"
    holder = term.def_array.each { |x| puts x }
    puts term.word + ":  " + "#{holder}"
  end
  main_menu
end

def edit_menu
  puts "Enter the word you would like to edit: "
  edit_word = gets.chomp
  puts "Press 'W' to edit #{edit_word}."
  puts "Press 'D' to edit #{edit_word}'s' definition."
  puts "Press 'A' to add more definitions"
  puts "Press 'L' to add another language for a word"
  puts "Press 'X' to delete this word"
  edit_choice = gets.chomp.downcase
  if edit_choice == 'w'
    Term.all.each do |term|
      if term.word == edit_word
        puts "What would you like to change #{edit_word} to"
        new_word = gets.chomp
        term.edit_word(new_word)
        show_definitions
      else
        puts "That is not a word in the dictionary"
        edit_menu
      end
    end
  elsif edit_choice == 'd'
    Term.all.each do |term|
      if term.word == edit_word
        puts "What would you like to change #{edit_word}'s definition to"
        new_definition = gets.chomp
        term.edit_definition(new_definition)
        show_definitions
      else
        puts "That is not a word in the dictionary"
        edit_menu
      end
    end
  elsif edit_choice == 'a'
    "Please enter the additional definition: "
    new_def = gets.chomp
    Term.all.each do |x|
      if x.word == edit_word
        x.def_array << new_def
      end
    end
    main_menu
  elsif edit_choice == 'l'
    "Please enter the word's equivalent in the new language: "
    new_language = gets.chomp
    Term.all.each do |x|
      if x.word == edit_word
        x.word_array << new_language
      end
    end
    main_menu
  elsif edit_choice == 'x'
    Term.all.delete_if {|stuff| stuff.word == edit_word}
    show_definitions
  end
end

def search
  puts "Enter a word to search: "
  search_word = gets.chomp
  search_word = Term.search(search_word)
  puts search_word.word + ": " + search_word.definition
  main_menu
end

















main_menu






# definitions.to_enum.with_index(1).each do |elem, i|
#   puts "#{i}: #{elem}"
# end
