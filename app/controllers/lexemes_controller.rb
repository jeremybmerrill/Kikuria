class LexemesController < ApplicationController
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
    @regex = params[:regex]
    Lexeme.all.each do |lexeme|
        @matches << lexeme if Regexp.new(params[:regex]).match(lexeme.token)
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

    respond_to do |format|
      if @lexeme.save
        format.html { redirect_to @lexeme, notice: 'Lexeme was successfully created.' }
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

    respond_to do |format|
      if @lexeme.update_attributes(params[:lexeme])
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
