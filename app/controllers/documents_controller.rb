class DocumentsController < ApplicationController
  def index
    if params[:document].present? && params[:document] == "Referral Letters"
      @documents = policy_scope(Document).where(doc_type: params[:document])
    elsif params[:document].present? && params[:document] == "Immunization Records"
      @documents = policy_scope(Document).where(doc_type: params[:immunization_records])
    elsif params[:document].present? && params[:document] == "Pathology Records"
      @documents = policy_scope(Document).where(doc_type: params[:pathology_records])
    elsif params[:document].present? && params[:document] == "Prescription Records"
      @documents = policy_scope(Document).where(doc_type: params[:prescription_records])
    elsif params[:document].present? && params[:document] == "Radiology Reports"
      @documents = policy_scope(Document).where(doc_type: params[:radiology_reports])
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

    @document_info = OcrScan.new(document_params[:photo].tempfile.path).scan

    if @document.save
      # TO DO: redirect to edit page
      redirect_to documents_path, notice: "Document was successfully uploaded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @document = Document.find(params[:id])
    @document.update(document_params)
    authorize @document
    redirect_to documents_path
  end

  def edit
    @document = Document.find(params[:id])
    authorize @document
  end

  private

  def document_params
    params.require(:document).permit(:doc_type, :country, :doctor_name, :comment, :date, :user_id, :photo)
  end
end
