class LexemesController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :edit, :update, :destroy, :new]

  # GET /lexemes
  # GET /lexemes.json
  def index
    @lexemes = Lexeme.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lexemes }
    end
  end

  # GET /lexemes/1
  # GET /lexemes/1.json
  def show
    @lexeme = Lexeme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lexeme }
    end
  end

  def search
    #@lexeme = Lexeme.find(params[:id])
    @matches = []
    #@nonmatches = []
    regex = params[:regex]
    regex = regex.gsub("C", "[bcdghjklmnN9rRstwy]")
    regex = regex.gsub("V", "[aeiouEIOU]")
    regex = Regexp.new(regex)

    fields = [params[:field]]
    if fields == ['all']
        fields = ['sgNounClassMorpheme', 'plNounClassMorpheme', 'root', 'sgTranscription', 'plTranscription']
    end
    
    Lexeme.all.each do |lexeme|
        fields.each do |field|
            @matches << lexeme if regex.match(lexeme[field]) and !@matches.include?(lexeme)
        end
        #@nonmatches << lexeme unless Regexp.new(params[:regex]).match(lexeme.token)
    end
    
    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @lexeme }
    end
  end

  # GET /lexemes/new
  # GET /lexemes/new.json
  def new
    @lexeme = Lexeme.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lexeme }
    end
  end

  # GET /lexemes/1/edit
  def edit
    @lexeme = Lexeme.find(params[:id])
  end

  # POST /lexemes
  # POST /lexemes.json
  def create

    @lexeme = Lexeme.new(params[:lexeme])

    @lexeme.editDate = Time.now
    
    [:root, :sgNounClassMorpheme, :plNounClassMorpheme].each do |item|
        @lexeme[item] = @lexeme.toOrth(@lexeme[item])
    end
    @lexeme.sgTranscription = @lexeme.sgNounClassMorpheme + @lexeme.root
    @lexeme.plTranscription = @lexeme.plNounClassMorpheme + @lexeme.root

    current_user.lexemes << @lexeme

    respond_to do |format|
      if @lexeme.save
        format.html { redirect_to lexemes_path, notice: 'Lexeme was successfully created.' }
        format.json { render json: @lexeme, status: :created, location: @lexeme }
      else
        format.html { render action: "new" }
        format.json { render json: @lexeme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lexemes/1
  # PUT /lexemes/1.json
  def update
    @lexeme = Lexeme.find(params[:id])
    
    updated_lexeme = params[:lexeme]

    sgNounClassMorpheme = updated_lexeme[:sgNounClassMorpheme] or @lexeme.sgNounClassMorpheme
    plNounClassMorpheme = updated_lexeme[:plNounClassMorpheme] or @lexeme.plNounClassMorpheme
    root = updated_lexeme[:root] or @lexeme.root
    
    updated_lexeme[:sgTranscription] = sgNounClassMorpheme + root unless (sgNounClassMorpheme.nil? or sgNounClassMorpheme == "")
    updated_lexeme[:plTranscription] = plNounClassMorpheme + root unless (plNounClassMorpheme.nil? or plNounClassMorpheme == "")

    respond_to do |format|
      if @lexeme.update_attributes(updated_lexeme)
        format.html { redirect_to @lexeme, notice: 'Lexeme was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @lexeme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lexemes/1
  # DELETE /lexemes/1.json
  def destroy
    @lexeme = Lexeme.find(params[:id])
    @lexeme.destroy

    respond_to do |format|
      format.html { redirect_to lexemes_url }
      format.json { head :ok }
    end
  end
end
