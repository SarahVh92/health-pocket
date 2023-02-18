require 'rqrcode'

class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update]

  def index
    if params[:document].present?
      if params[:document] == "Referral Letters"
        @referral_letters = policy_scope(Document).where(doc_type: params[:document])
      elsif params[:document] == "Immunization Records"
        @immunization_records = policy_scope(Document).where(doc_type: params[:document])
      elsif params[:document] == "Pathology Records"
        @pathology_records = policy_scope(Document).where(doc_type: params[:document])
      elsif params[:document] == "Prescription Records"
        @prescription_records = policy_scope(Document).where(doc_type: params[:document])
      else
        @radiology_reports = policy_scope(Document).where(doc_type: params[:document])
      end
    else
      @documents = policy_scope(Document)
    end
  end

  def new
    @document = Document.new
    authorize @document
  end

  def create
    @document = Document.new(document_params)
    authorize @document
    @document.user = current_user
    @document_info = OcrScan.new(document_params[:photo].tempfile.path).scan
    @document.doc_content = @document_info


    if @document.save
      redirect_to documents_path, notice: "Document was successfully uploaded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize @document
    @qr_code = RQRCode::QRCode.new("https://www.google.com")
    @svg = @qr_code.as_svg(
      offset: 0,
      color: 'dde0ab',
      module_size: 9,
      shape_rendering: 'crispEdges',
      standalone: true
    )
    @sentences = @document.doc_content
    if params[:language].present?
      raise
    end
      if params[:query].present?
       @lang = "ja"
       @translated_sentences = @document.doc_content.split("\n").map do |content|
         Translation.new.translate(@lang, content)
       end
         @sentences = @translated_sentences.join("\n")
     end
     @sentences
  end

  def update
    @document.update(document_params)
    authorize @document
    redirect_to documents_path
  end

  def edit
    authorize @document
  end

  private

  def document_params
    params.require(:document).permit(:doc_type, :country, :doctor_name, :comment, :date, :photo, :qr_code, :doc_content)
  end

  def set_document
    @document = Document.find(params[:id])
  end
end
