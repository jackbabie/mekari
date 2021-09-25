module ExtractSubject
  def extract_subject(lyrics = [])
    lyrics.map do |lyric|
      words = lyric.split
      cut_index = words.find_index(rule)
      words.slice(0, cut_index).join(' ')
    end
  end

  private
  def rule
    'that'
  end
end

class BaseReciter
  def self.recite(lyrics, recite_number)
    'This is '
  end
end

class NormalReciter < BaseReciter
  def self.recite(lyrics, recite_number)
    super +  lyrics.last(recite_number).join(' ')
  end
end

class RandomReciter < BaseReciter
  def self.recite(lyrics, recite_number)
    super + lyrics.sample(recite_number).last(recite_number).join(' ')
  end
end

class SubjectOnlyReciter < BaseReciter
  extend ExtractSubject

  def self.recite(lyrics, recite_number)
    super + self.extract_subject(lyrics.last(recite_number)).join(', ')
  end
end

class SubjectOnlyRandomReciter < BaseReciter
  extend ExtractSubject

  def self.recite(lyrics, recite_number)
    super + self.extract_subject(lyrics.sample(recite_number).last(recite_number)).join(', ')
  end
end

class JackHouseLyric
  attr_reader :lyrics, :output_class
  def initialize(output_class = NormalReciter)
    @lyrics = [
      'the horse and the hound and the horn that belonged to',
      'the farmer sowing his corn that kept',
      'the rooster that crowed in the morn that woke',
      'the priest all shaven and shorn that married',
      'the man all tattered and torn that kissed',
      'the maiden all forlorn that milked',
      'the cow with the crumpled horn that tossed',
      'the dog that worried',
      'the cat that killed',
      'the rat that ate',
      'the malt that lay in',
      'the house that Jack built',
    ]

    @output_class = output_class
  end

  def recite(recite_number)
    @output_class.recite(@lyrics, recite_number)
  end
end


def get_input
  puts ' ------- THIS IS THE HOUSE THAT JACK BUILT -------
  the horse and the hound and the horn that belonged to
  the farmer sowing his corn that kept
  the rooster that crowed in the morn that woke
  the priest all shaven and shorn that married
  the man all tattered and torn that kissed
  the maiden all forlorn that milked
  the cow with the crumpled horn that tossed
  the dog that worried
  the cat that killed
  the rat that ate
  the malt that lay in
  the house that Jack built
  '

  loop do
    puts 'Choose Recite method. Default (1):
      1. Normal Reciter
      2. Random Reciter
      3. Subject Only Reciter
      4. Subject Only Random Reciter '

    output_class = case gets.chomp.to_i
                   when 0, 1
                     NormalReciter
                   when 2
                     RandomReciter
                   when 3
                     SubjectOnlyReciter
                   when 4
                     SubjectOnlyRandomReciter
                  else
                    p 'Wrong Input'
                  end
    puts "You chose #{output_class.name}"

    puts 'How many recite?'
    recite_number =  gets.chomp.to_i


    lyricReciter = JackHouseLyric.new(output_class)
    p lyricReciter.recite(recite_number)

    puts 'Continue (Enter/Y). Exit(N)'
    continue =  gets.chomp.upcase

    break if continue == 'N'
  end
end

get_input
