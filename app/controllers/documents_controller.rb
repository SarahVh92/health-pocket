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

private
  def document_params
    params.require(:document).permit(:doc_type, :country, :doctor_name, :comment, :date, :user_id)
  end
end
