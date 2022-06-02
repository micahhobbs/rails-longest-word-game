require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word_string = params[:word].upcase.delete(' ')
    @word_chars_array = @word_string.split('')
    @generated_letters_string = params[:generated_letters]
    @generated_letters_array = @generated_letters_string.split(' ')
    @legit = true
    @word_chars_array.each do |char|
      @legit = false if @generated_letters_array.exclude? char
    end
    score_word if @legit
  end

  private

  def score_word
    url = "https://wagon-dictionary.herokuapp.com/#{@word_string}"
    score_response = URI.open(url).read
    @score = JSON.parse(score_response)
  end
end
