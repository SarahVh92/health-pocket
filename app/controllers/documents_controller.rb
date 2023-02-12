class DocumentsController < ApplicationController
  def index
    if params[:document].present? && params[:document] == "Referral Letters"
      @documents = policy_scope(Document).where(doc_type: params[:document])
    elsif params[:document].present? && params[:document] == "Immunization Records"
      @documents = policy_scope(Document).where(doc_type: params[:document])
    elsif params[:document].present? && params[:document] == "Pathology Records"
      @documents = policy_scope(Document).where(doc_type: params[:document])
    elsif params[:document].present? && params[:document] == "Prescription Records"
      @documents = policy_scope(Document).where(doc_type: params[:document])
    elsif params[:document].present? && params[:document] == "Radiology Reports"
      @documents = policy_scope(Document).where(doc_type: params[:document])
    else
      @documents = policy_scope(Document)
    end
  end


  def update
    @document = Document.find(params[:id])
    @document.update(document_params)
    authorize @document
    redirect_to documents_path
  end

  def edit
    @document = Document.new
    # @document = Document.find(params[:id])
    authorize @document
  end

  def new
    @document = Document.new
    authorize @document
  end

  def create
    @document = Document.new(document_params)
    authorize @document

    @document_info = OcrScan.new(document_params[:photo].tempfile.path).scan
    @document.user = current_user

    if @document.save
      redirect_to documents_path, notice: "Image was successfully scanned."
    else
      render :new
    end
  end

  private

  def document_params
    params.require(:document).permit(:doc_type, :pays, :doctor_name, :comment, :date, :photo)
  end
end
