class ComputerPlayer

	attr_accessor :secret_number

	def initialize
		@secret_number = (1..6).to_a.shuffle.take(4)
		# Array.new(4) { rand(1..6)}
	end

end

class HumanPlayer

	attr_accessor :name

	def initialize
		@name = new_player
	end

	def new_player
		puts "What is your name, human?"
		gets.chomp
	end

	def guess
		puts "What's your guess?"
		guess = gets.chomp.split('')
		guess.map! { |i| i.to_i}
		puts "Your guess is #{guess}"
		guess
	end

end

class Game

	def initialize
		@computer = ComputerPlayer.new
		@human = HumanPlayer.new
		game_loop(@human, @computer)
	end

	def compare(guess, secret)
		result = []
		secret.each_with_index do |number,outer_index|
			guess.each_with_index do |digit, inner_index|
				if digit == number && outer_index == inner_index
					result.push("black")
				elsif digit == number
					result.push("white")
				end
			end
		end
		result.sort!
	end

	def winning?(guess, secret)
		if
			compare(guess, secret) == ["black","black","black","black"]
			return true
		end
		false
	end

	def restart
		puts "Do you want to play again? yes/no "
		answer = gets.chomp.downcase
		if answer == "yes"
			game = Game.new 
		elsif answer == "no"
			puts "Thanks for playing!"
			exit
		else
			puts "I don't think that's one of the options."
			restart
		end
	end

	def game_loop(human, computer)
		secret = computer.secret_number
		# p secret
		12.times do
			guess = human.guess
			p compare(guess, secret)
			if winning?(guess, secret)
				puts "You did it!"
				restart
			end
		end
		puts "Good effort! But not good enough."
		restart
	end
end

game = Game.new
# test_guess = [2,4,6,7]
# test_secret = [1,4,2,7]

