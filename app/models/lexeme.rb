# encoding: UTF-8

class Lexeme < ActiveRecord::Base
  validates :token, :presence => true

  def toOrth(lexeme)
    #translates non-standard (relative to Jeremy :D) symbols to Jeremy's preferred monograph-only orthography.
    #rr -> R; ñ ny -> 9; ng' -> N; ch -> c; j -> y
    lexeme.gsub("rr", "R").gsub("ny", "9").gsub("ñ", "9").gsub("ng'", "N").gsub("ch", "c").gsub("j", "y")
  end

  def toDisplayOrth(lexeme, prefs)
    #convert a lexeme's stored representation (in Jeremy's preferred orthography) to arbitrary orthography.
    #prefs is a hash with members :trill, :palatalnasal, :velarnasal, :palatalaffricate, :palatalglide
  
    #sets defaults
    prefs[:trill] = "R" if !prefs[:trill]
    prefs[:palatalnasal] = "9" if !prefs[:palatalnasal]
    prefs[:velarnasal] = "N" if !prefs[:velarnasal]
    prefs[:palatalaffricate] = "c" if !prefs[:palatalaffricate]
    prefs[:palatalglide] = "y" if !prefs[:palatalglide]
    
    lexeme.gsub("R", prefs[:trill]).gsub("9", prefs[:palatalnasal]).gsub("N", prefs[:velarnasal]).gsub("c", prefs[:palatalaffricate]).gsub("y", prefs[:palatalglide])
  end
end
