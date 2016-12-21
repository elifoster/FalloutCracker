require 'sinatra'
require_relative 'helpers/helper'

helpers Helper

get '/' do
  erb :index
end

post '/first' do
  words = only_words(params[:words]).map(&:upcase)
  rejects = words.reject { |x| x.length == words[0].length }
  if rejects.empty?
    erb(:select, locals: { words: words })
  else
    erb(:badlen, locals: { badwords: rejects })
  end
end

post '/filter' do
  p params
  num_correct = params[:num].to_i
  words = only_words(params[:words])
  selected_word = params[:word]
  selected_word_chars = selected_word.chars
  words.delete_if { |word| selected_word_chars
                           .each_with_index.select { |char, index| word.chars[index] == char }
                           .map { |arr| arr[0] }
                           .size != num_correct
  }

  if words.empty?
    erb :none
  elsif words.size == 1
    erb(:done, locals: { word: words[0] })
  else
    erb(:select, locals: { words: words })
  end
end
