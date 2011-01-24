# encoding: utf-8

class Manage::PublicationsController < Manage::ApplicationController

  load_resource :except => :get_fields
  authorize_resource :class=> Publication

  custom_actions :resource => [:transit, :delete]

  belongs_to :chair, :finder => :find_by_slug

  def index
    search = Publication.search(params[:query], @chair, params)
    @publications = search.results
    @facets = search.facet(:kind).rows
  end

  def transit
    transit! do
      @publication.send "#{params[:event]}!" if @publication.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to resource_path and return
    end
  end

  def get_fields
    render :text => "" and return if params[:publication][:kind].blank?
    params[:publication].delete("authors_attributes")
    params[:publication].delete("attachment_attributes")
    @publication = Publication.new(params[:publication])
    render :partial => "/manage/publications/fields"
  end

  def to_report
    @chair = Chair.find(params[:chair_id])
    report_filename = "publication.odt"

    @extention = Rails::env.production? ? "doc": "odt"
    @mime_type = MIME::Types.of(@extention).first.content_type

    begin
      data = generate_data('publication', 'publication', @publication.to_xml)
      send_data data, :type => @mime_type, :filename => report_filename
    rescue Exception => e
      redirect_to manage_chair_publication_path(@chair, @publication)
    end
  end

  private

  def generate_data(report_name, template_path, xml)
    template_path = Rails.root.join("reports", "#{template_path}.odt").to_s

    result_data = ""

    Tempfile.open ["data_file", ".xml"] do |data_file|

      data_file << xml
      data_file.flush

      Tempfile.open [report_name, ".odt"] do | odt_file |
        libdir = Rails.root.join "reports", "lib"
        result = system("java", "-Djava.ext.dir=#{libdir}", "-jar", "#{libdir}/jodreports-2.1-RC.jar", template_path, data_file.path, odt_file.path)
        raise "Ошибка создания документа #{report_name}" unless result

        if @extention == "doc"
          Tempfile.open [report_name, ".doc"] do | doc_file |
            system("java", "-Djava.ext.dir=#{libdir}", "-jar", "#{libdir}/jodconverter-cli-2.2.2.jar", odt_file.path, doc_file.path)
            result_data = File.read(doc_file.path)
          end
        else
          result_data = File.read(odt_file.path)
        end
      end
    end
    result_data
  end


end

