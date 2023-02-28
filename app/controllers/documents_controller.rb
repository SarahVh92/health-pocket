require 'rqrcode'

class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update]

  def index
    @documents = policy_scope(Document)
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

  # def remove_quotations(str)
  #   if str.start_with?('"')
  #     str = str.slice(1..-1)
  #   end
  #   if str.end_with?('"')
  #     str = str.slice(0..-2)
  #   end
  # end

  def show
    authorize @document
    @qr_code = RQRCode::QRCode.new("www.healthpocket.online#{document_path(@document, format: :pdf)}")
    @svg = @qr_code.as_svg(
      offset: 0,
      color: 'dde0ab',
      module_size: 9,
      shape_rendering: 'crispEdges',
      standalone: true
    )

    @sentences = JSON.parse(@document.doc_content)

    if params[:query].present?
      @sentences = @sentences.map do |content|
        Translation.new.translate(params[:query], content)
      end
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@document.user.last_name} - #{@document.user.first_name}", # filename
                template: "layouts/pdf",
                formats: [:pdf],
                disposition: :inline,
                layout: 'pdf',
                locals: { sentences: @sentences },
                encoding: "UTF-8",
                show_as_html: params[:debug].present?
      end
    end
    # else
    #   @sentences = @document.doc_content

    #   respond_to do |format|
    #     format.html
    #     format.pdf do
    #       render pdf: "#{@document.user.last_name} - #{@document.user.first_name}", # filename
    #               template: "layouts/pdf",
    #               formats: [:pdf],
    #               disposition: :inline,
    #               layout: 'pdf',
    #               locals: { sentences: @sentences }
    #     end
    #   end

    # end
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
