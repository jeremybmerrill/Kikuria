class StaticPagesController < ApplicationController
  def home
    @recentlexemes = Lexeme.order("updated_at DESC").limit(5)
    @recentsyntagms = Syntagm.order("updated_at DESC").limit(5)
  end

  def search
  end

  def help
  end

end
