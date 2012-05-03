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

  def search
    @matches = []
    #@nonmatches = []
    regex = params[:regex]
    regex = regex.gsub("C", "[bcdghjklmnN9rRstwy]")
    regex = regex.gsub("V", "[aeiouEIOU]")

    fields = [params[:field]]
    if fields == ['all']
        fields = ['token', 'gloss', 'notes',]
    end
    
    Syntagm.all.each do |syntagm|
        regexp = Regexp.new(syntagm.toOrth(regex))
        fields.each do |field|
            @matches << syntagm if regex.match(syntagm[field]) and !@matches.include?(syntagm)
        end
        #@nonmatches << syntagm unless Regexp.new(params[:regex]).match(syntagm.token)
    end
    
    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @syntagm }
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

    @syntagm.editDate = Time.now
    
    @syntagm[:token] = @syntagm.toOrth(@syntagm[:token])

    @syntagm.audio = Audio.find(params[:audio]) unless params[:audio].nil? or params[:audio] == ""

    current_user.syntagms << @syntagm

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

    @syntagm.editDate = Time.now
    
    @syntagm[:token] = @syntagm.toOrth(@syntagm[:token])

    @syntagm.audio = Audio.find(params[:audio]) unless params[:audio].nil? or params[:audio] == ""

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

  # adapted from http://oldwiki.rubyonrails.org/rails/pages/HowtoExportDataAsCSV
  # and http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
  def export_csv
    filename = "Kikuria_syntagms"    

    #this is required if you want this to work with IE		
    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain"
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      headers['Expires'] = "0"
    end

    syntagms = Syntagm.find(:all)
    csv_data = CSV.generate do |csv|
      csv << [ "token", "gloss", "grammatical", "classOrGroup", "notes", "editDate", "user_id", "created_at", "updated_at"]
      syntagms.each do |s|
        csv << [s.token, s.gloss, s.grammatical, s.classOrGroup, s.notes, s.editDate, s.user_id, s.created_at, s.updated_at]
      end
    end
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end

end
