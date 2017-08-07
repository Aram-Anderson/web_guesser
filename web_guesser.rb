require 'sinatra'
require 'sinatra/reloader'

num = rand(1..100)

get '/' do
	guess = params["guess"]
	message, color = check_guess(guess, num)
	erb :index, :locals => { :message => message, :color => color }
end

def check_guess(guess, num)
	if guess_does_not_exist(guess)
		message = "Guess a number between 0 and 100."
		color   = "white"
	elsif guess_is_correct?(guess, num)
		message = "You got it right! The secret number was #{num}."
		color   = "green"
	elsif guess_is_high_but_close(guess, num)
		message =  "Too high, but close! Try again!"
		color   = "yellow"
	elsif guess_is_low_but_close(guess, num)
		message = "Too low, but close! Try again!"
		color   = "yellow"
	elsif guess_is_way_too_high(guess, num)
		message = "Way too high. Try again."
		color   = "red"
	elsif guess_is_way_too_low(guess, num)
		message = "Way too low. Try again."
		color   = "red"
	end
	[message, color]
end

def guess_does_not_exist(guess)
	!((1..100).cover? guess.to_i)
end

def guess_is_correct?(guess, num)
	guess.to_i == num
end

def guess_is_high_but_close(guess, num)
	guess.to_i > num && guess.to_i <= num  + 5
end

def guess_is_low_but_close(guess, num)
	guess.to_i < num && guess.to_i >= num - 5
end

def guess_is_way_too_high(guess, num)
	guess.to_i > num + 5
end

def guess_is_way_too_low(guess, num)
	guess.to_i < num - 5
end
