class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def identify
    respond_to do |format|
     '<description>
       <oai-identifier
             xmlns="http://www.openarchives.org/OAI/2.0/oai-identifier"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai-identifier
                        http://www.openarchives.org/OAI/2.0/oai-identifier.xsd">
          <scheme>oai</scheme>
          <repositoryIdentifier>kikuria.herokuapp.com</repositoryIdentifier>
          <delimiter>:</delimiter>
       </oai-identifier>
    </description>
    <description>
       <olac-archive
             xmlns="http://www.language-archives.org/OLAC/1.0/"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://www.language-archives.org/OLAC/1.0/
                        http://www.language-archives.org/OLAC/1.0/olac-archive.xsd"
             type="personal">
          <archiveURL>http://kikuria.herokuapp.com</>
          <curator>Jeremy B. Merrill</curator>
          <curatorTitle>Awesome Dude</curatorTitle>
          <curatorEmail>mailto:jeremybmerrill@gmail.com</curatorEmail>
          <institution>Ehhh? Developed for Pomona College, I\'m not a student anymore though</institution>
          <institutionURL>http://pomona.edu</institutionURL>
          <shortLocation>Claremont, CA</shortLocation>
          <location>Claremont, CA, U.S.A.</location>
          <synopsis>Lexical items and phrases in Kuria, gathered Spring 2011.</synopsis>
          <access>Open. CC 3.0 BY-NC-SA</access>
       </olac-archive>
    </description>'
    end
  end
end
