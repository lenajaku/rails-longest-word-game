require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do |letter|
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @score = params[:word].length
    if english_word?(@word)
      if @word.split('').all? {|letter| @letters.split.include?(letter)}
      @answer = "Congratulations! #{@word.upcase} is a valid english word! Your score is #{@score}"
      else
      @answer = "Sorry but #{@word.upcase} can't be build out of #{@letters.upcase}"
      end
    else
    @answer = "#{@word.upcase} is not an english word"
    end
  end

  def english_word?(attempt)
  url = open("https://wagon-dictionary.herokuapp.com/#{attempt}")
  check = JSON.parse(url.read)
  check['found']
  end
end
