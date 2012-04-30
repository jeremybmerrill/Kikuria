# encoding: UTF-8

class SyntagmsController < ApplicationController

  load_and_authorize_resource


  # GET /syntagms
  # GET /syntagms.json
  def index
    @syntagms = Syntagm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @syntagms }
    end
  end

  # GET /syntagms/1
  # GET /syntagms/1.json
  def show
    @syntagm = Syntagm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @syntagm }
    end
  end

  # adapted from http://oldwiki.rubyonrails.org/rails/pages/HowtoExportDataAsCSV
  def export_syntagms_csv
    syntagms = Syntagm.find(:all)
    stream_csv do |csv|
      csv << [ "token", "gloss", "grammatical", "classOrGroup", "notes", "editDate", t.integer "user_id", "created_at", "updated_at"]
      syntagms.each do |s|
        csv << [s.token, s.gloss, s.grammatical, s.classOrGroup, s.notes, s.editDate, s.user_id, s.created_at, s.updated_at]
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

  # GET /syntagms/new
  # GET /syntagms/new.json
  def new
    @syntagm = Syntagm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @syntagm }
    end
  end

  # GET /syntagms/1/edit
  def edit
    @syntagm = Syntagm.find(params[:id])
  end

  # POST /syntagms
  # POST /syntagms.json
  def create
    @syntagm = Syntagm.new(params[:syntagm])

    respond_to do |format|
      if @syntagm.save
        format.html { redirect_to @syntagm, notice: 'Syntagm was successfully created.' }
        format.json { render json: @syntagm, status: :created, location: @syntagm }
      else
        format.html { render action: "new" }
        format.json { render json: @syntagm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /syntagms/1
  # PUT /syntagms/1.json
  def update
    @syntagm = Syntagm.find(params[:id])

    respond_to do |format|
      if @syntagm.update_attributes(params[:syntagm])
        format.html { redirect_to @syntagm, notice: 'Syntagm was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @syntagm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syntagms/1
  # DELETE /syntagms/1.json
  def destroy
    @syntagm = Syntagm.find(params[:id])
    @syntagm.destroy

    respond_to do |format|
      format.html { redirect_to syntagms_url }
      format.json { head :ok }
    end
  end
end
