
def ask_question(question, input_data_type: Integer)
  print question + " "
  user_input = gets.chomp
  while user_input.class != input_data_type
    puts "Invalid input. Please try again."
  end
end

if (File.exist? "bank_balance.txt") == true
  money_balance = (IO.read "bank_balance.txt").to_i
else
  File.new "bank_balance.txt", "w"
  money_balance = 0
end

if (File.exist? "bank_transactions.txt") == true
  history_string = IO.read "bank_transactions.txt"
  history = history_string.split(",")
else
  File.new "bank_transactions.txt", "w"
  history = []
end

puts "Welcome to Jeff's Banking App.\nPlease type in your password."
password = gets.chomp.downcase

puts "The current balance in your bank account is: $#{money_balance}"

loop do
  puts "What would you like to do today? [balance, deposit, withdraw, history, clear, quit]"
  input = gets.chomp.downcase
  case
  when input == "balance"
    puts "Your balance is: $#{money_balance}"
  when input == "clear"
    system "clear"
  when input == "quit"
    puts "Thank you for using Jeff's Banking App. Have a good day!"
    break
  when input == "deposit"
    puts "How much would you like to deposit?"
    money_deposit = gets.chomp.to_i
    money_balance += money_deposit
    puts "Your balance is: $#{money_balance}"
    history.push "You deposited $#{money_deposit} at #{Time.now}"
  when input == "withdraw"
    puts "How much would you like to withdraw?"
    money_withdraw = gets.chomp.to_i
    while money_withdraw > money_balance
      puts "You don't have that much money! Choose a smaller amount."
      money_withdraw = gets.chomp.to_i
    end
    money_balance -= money_withdraw
    puts "Your balance is: $#{money_balance}"
    history.push "You withdrew $#{money_withdraw} at #{Time.now}"
  when input == "history"
    puts history
  else
    puts "Invalid selection! Please try again."
  end
end

IO.write "bank_balance.txt", money_balance
history_string = history.join ","
IO.write "bank_transactions.txt", history_string
