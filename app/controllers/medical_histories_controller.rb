class MedicalHistoriesController < ApplicationController
  # before_action :set_medical_history, only: %i[show]

  # def index
  #   @medical_history = MedicalHistory.new
  #   @medical_histories = policy_scope(MedicalHistory)
  # end

  # def show
  #   @medical_history = MedicalHistory.find(params[:id])
  #   authorize @medical_history
  # end

  def new
    @medical_history = MedicalHistory.new
    authorize @medical_history
  end

  def create
    @medical_history = MedicalHistory.new(medical_history_params)
    authorize @medical_history
    @medical_history.user = current_user
    if @medical_history.save
      redirect_to new_medical_history_path, notice: 'You have successfully added to your medical history.'

    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def medical_history_params
    params.require(:medical_history).permit(:disease, :start_date)
  end

  # def set_medical_history
  #   @medical_history = MedicalHistory.find(params[:id])
  # end
end
