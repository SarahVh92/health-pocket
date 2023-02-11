class DocumentsController < ApplicationController
  def index
    @documents = policy_scope(Document)
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
      # redirect_to
    else
      render :new
    end
  end

  private
  def document_params
    params.require(:document).permit(:doc_type, :country, :doctor_name, :comment, :date, :user_id, :photo)
  end
end
