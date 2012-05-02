# encoding: UTF-8

class Lexeme < ActiveRecord::Base
  belongs_to :user

  belongs_to :audio
  has_many :comments, :as => :commentable

  validates :root, :presence => true
  validates :gloss, :presence => true

  def Lexeme.toOrth(item)
=begin
#I wish Ruby had Python's unit test stuff.
Lexeme.toOrth("omorronyong'chjo")
 => "omoRo9oNcyo" 
=end
    #translates non-standard (relative to Jeremy :D) symbols to Jeremy's preferred monograph-only orthography.
    #rr -> R; ñ ny -> 9; ng' -> N; ch -> c; j -> y
    subpairs = []
    subpairs << ["rr", "R"]
    subpairs << ["ny", "9"]
    subpairs << ["ñ", "9"]
    subpairs << ["ng'", "N"]
    subpairs << ["ch", "c"]
    subpairs << ["j", "y"]
    subpairs << ["β","b"]
    subpairs << ["ɣ","g"]
    subpairs << ["ɾ","r"]
    subpairs << ["r","R"]
    subpairs << ["t͡ʃ","c"]
    subpairs << ["ɲ","9"]
    subpairs << ["ŋ","N"]
    subpairs << ["j","y"]
    subpairs << ["ɪ","I"]
    subpairs << ["ʊ","U"]
    subpairs << ["ɛ","E"]
    subpairs << ["ɔ","O"]

    subpairs.each do |subpair|
        item = item.gsub(subpair[0], subpair[1])
    end
    return item
  end

  def Lexeme.toDisplayOrth(item, prefs)
    #convert a lexeme's stored representation (in Jeremy's preferred orthography) to arbitrary orthography.
    #prefs is a hash with members :trill, :palatalnasal, :velarnasal, :palatalaffricate, :palatalglide
  
    #sets defaults
    prefs[:trill] = "R" if !prefs[:trill]
    prefs[:palatalnasal] = "9" if !prefs[:palatalnasal]
    prefs[:velarnasal] = "N" if !prefs[:velarnasal]
    prefs[:palatalaffricate] = "c" if !prefs[:palatalaffricate]
    prefs[:palatalglide] = "y" if !prefs[:palatalglide]
    
    return item.gsub("R", prefs[:trill]).gsub("9", prefs[:palatalnasal]).gsub("N", prefs[:velarnasal]).gsub("c", prefs[:palatalaffricate]).gsub("y", prefs[:palatalglide])
  end

  def toOrth(item) #for backwards compatibility
    return Lexeme.toOrth(item)
  end
  def toDisplayOrth(item, prefs)
    return Lexeme.toDisplayOrth(item, prefs)
  end

  #xml = Nokogiri::XML(File.read('http://linguistics-ontology.org/gold-2010.xml'))
  #partOfSpeechNodes = doc.xpath('//concept[@parent="http://purl.org/linguistics/gold/PartOfSpeechProperty"]/label')
  #partsOfSpeech = []
  #partOfSpeechNodes.each do |node|
  #  partsOfSpeech << node.text
  #end
  def Lexeme.partsOfSpeech
    #you might need to customize this for languages other than Kikuria.
    return ["Adjective", "Adverb", "NegationOperator", "Noun", "Preposition", "Pronoun", "Quantifier", "Verb"]
  end
  def Lexeme.translateToGold(elem)
    if elem == "Pronoun"
        return "Pronominal"
    elsif elem == "Verb"
        return "Verbal"
    elsif elem == "Adjective"
        return "Adjectival"
    elsif elem == "Adverb"
        return "Adverbial"
    elsif elem == "TomorrowFutureTense"
        return "CrastinalFutureTense"
    elsif elem == "YesterdayPastTense"
        return "HesternalPastTense"
    elsif elem == "TodayPastTense"
        return "HodiernalPastTense"
    elsif elem == "TodayFutureTense"
        return "HodiernalFutureTense"
    elsif Lexeme.partsOfSpeech.include? elem or Lexeme.tenses.include? elem
        return elem
    else
        raise ArgumentError, "I don't know what " + elem + " is!"
    end
  end

  def Lexeme.tenses
    #You'll definitely need to customize this for other languages!
    return ["RemoteFutureTense", "TomorrowFutureTense", "TodayFutureTense", "TodayPastTense", "PresentTense", "YesterdayPastTense", "RemotePastTense",]
  end

end
