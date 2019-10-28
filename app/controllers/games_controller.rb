require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    session[:score] = session[:score] || 0
    @score = session[:score]
    @letters = []
    10.times { @letters << "ABCDEFGHIJKLMNOPQRSTUVWXYZ".chars.sample }
  end

  def score
    @guess = params[:guess].strip.upcase
    @letters = params[:letters].upcase

    @in_letters = true
    @guess.chars.each do |letter|
      @in_letters = false if @guess.count(letter) > @letters.count(letter)
    end

    response = open("https://wagon-dictionary.herokuapp.com/#{@guess.downcase}")
    @valid_word = JSON.parse(response.string)["found"]

    session[:score] += @guess.length if @in_letters && @valid_word
    @score = session[:score]
  end
end
