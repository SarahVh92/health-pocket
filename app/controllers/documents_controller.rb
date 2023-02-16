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
      color: '000',
      width: 200,
      height: 200,
      shape_rendering: 'crispEdges',
      standalone: true
    )
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
    params.require(:document).permit(:doc_type, :country, :doctor_name, :comment, :date, :photo, :qr_code)
  end

  def set_document
    @document = Document.find(params[:id])
  end
end
