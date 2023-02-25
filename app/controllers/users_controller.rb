class UsersController < ApplicationController
 # def index
  #  @d = policy_scope(Document)
   # if params[:user].present?
    #  if params[:user] == ""
     #   @referral_letters = policy_scope(User).where(doc_type_type: params[:document])
      #elsif params[:document] == "Immunization Records"
       # @immunization_records = policy_scope(Document).where(doc_type: params[:document])
      #elsif params[:document] == "Pathology Records"
       # @pathology_records = policy_scope(Document).where(doc_type: params[:document])
      #elsif params[:document] == "Prescription Records"
       # @prescription_records = policy_scope(Document).where(doc_type: params[:document])
      #else
       # @radiology_reports = policy_scope(Document).where(doc_type: params[:document])
      #end
    #end
  #end


  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
