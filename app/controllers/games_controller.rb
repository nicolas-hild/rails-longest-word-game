require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    @letters << alphabet.sample until @letters.length == 10
    @letters
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params['word']}"
    word = params['word']
    grid = params['grid'].split(' ')
    session[:score] = 0 if session[:score].nil?
    @total_score = session[:score]
    user_attempt = open(url).read
    verification = JSON.parse(user_attempt)
    grid_word = in_the_grid(word, grid)
    user_score = (word.length * 10)

    @result = win_lose_message(verification, grid_word, user_score, word)
  end

  private

  def in_the_grid(attempt, grid)
    result_booleans = []
    attempt.upcase.split('').each do |letter|
      if grid.include?(letter)
        result_booleans << true
        index = grid.index(letter)
        grid.delete_at(index)
      else result_booleans << false
      end
    end
    result_booleans.all?
  end

  def win_lose_message(verification, grid_word, user_score, user_word)
    if verification['found'] == true && grid_word == true
      update(user_score)
      "Well done. Your score is #{user_score}"
    elsif verification['found'] == false && grid_word == true
      "Sorry but '#{user_word.upcase}' is not english"
    elsif verification['found'] == true
      "sorry but '#{user_word.upcase}' don\'t use letters from the grid"
    else
      "sorry but '#{user_word.upcase}' don\'t use letters from the grid"
    end
  end

  def update(user_score)
    session[:score] += user_score
    @total_score = session[:score]
  end
end
