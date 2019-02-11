class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses, :correct_guesses, :word_with_guesses, :counter
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @correct_guesses = ''
    @word_with_guesses = ''
    @counter = 0
    
    self.word.length.times { word_with_guesses << '-' }
  end
  
  def check_win_or_lose
    if !word_with_guesses.include?('-')
      return :win
    elsif counter>=7
      return :lose
    else
      return :play
    end
  end
  
  def guess(letter)
    
    if letter =~ /[A-Za-z]/
      
      letter.downcase!
      if self.word.include?(letter)
      
        if !guesses.include?(letter)
          guesses << letter
          
          self.word.length.times do |i|
            if word[i]==letter
              word_with_guesses[i] = letter
            end
          end
        else 
          return false
        end
    
        correct_guesses << letter
    
      else
      
        if !wrong_guesses.include?(letter)
        wrong_guesses << letter
        self.counter +=1
        else
          return false
        end
      end
    else
      raise ArgumentError.new("invalid letter")
      return false
    end
    
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
