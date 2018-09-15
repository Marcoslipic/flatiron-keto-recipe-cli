module Menu
  def menu
    self.print_all
    input_prompt = "Enter the #{self.type}'s number, type 'list' to show the #{self.type} list, or type 'exit':"
    puts input_prompt
    input = nil
    while input != "exit"
      input = gets.chomp.downcase
      if input.to_i > 0
        index = input.to_i - 1
        return index
      elsif input == "list"
        self.print_all
      elsif input == "exit"
        puts "Goodbye!"
        exit
      else
        puts "Sorry, I didn't understand that.  #{input_prompt}" 
      end
    end
  end
end