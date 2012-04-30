# encoding: UTF-8

class LexemesController < ApplicationController
  #before_filter :authenticate_user!, :only => [:create, :edit, :update, :destroy, :new]
  load_and_authorize_resource


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

  # adapted from http://oldwiki.rubyonrails.org/rails/pages/HowtoExportDataAsCSV
  def export_lexemes_csv
    lexemes = Lexeme.find(:all)
    stream_csv do |csv|
      csv << ["token","gloss","pos","root","sgNounClassMorpheme", "sgNounClassNumber", "plNounClassNumber", "classOrGroup", "transcription", "editDate", "sgTranscription", "plTranscription","infTranscription", "additionalForms", "notes", "created_at", "updated_at", "plNounClassMorpheme", "user_id", "basicWord"]
      lexemes.each do |l|
        csv << [l.token, l.gloss, l.pos, l.root, l.sgNounClassMorpheme, l.sgNounClassNumber, l.plNounClassNumber, l.classOrGroup, l.transcription, l.editDate, l.sgTranscription, l.plTranscription, l.infTranscription, l.additionalForms, l.notes, l.created_at, l.updated_at, l.plNounClassMorpheme, l.user_id, l.basicWord]
      end
    end
  end

  private
    def stream_csv
       filename = params[:action] + ".csv"    
	
       #this is required if you want this to work with IE		
       if request.env['HTTP_USER_AGENT'] =~ /msie/i
         headers['Pragma'] = 'public'
         headers["Content-type"] = "text/plain"
         headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
         headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
         headers['Expires'] = "0"
       else
         headers["Content-Type"] ||= 'text/csv'
         headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
       end
 
      render :text => Proc.new { |response, output|
        csv = FasterCSV.new(output, :row_sep => "\r\n") 
        yield csv
      }
    end


  def search
    #@lexeme = Lexeme.find(params[:id])
    @matches = []
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
      format.json { render json: @matches }
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
    @lexeme.sgTranscription = @lexeme.sgNounClassMorpheme + @lexeme.root unless (@lexeme.sgNounClassMorpheme.nil? or @lexeme.sgNounClassMorpheme == "")
    @lexeme.plTranscription = @lexeme.plNounClassMorpheme + @lexeme.root unless (@lexeme.plNounClassMorpheme.nil? or @lexeme.plNounClassMorpheme == "")

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
