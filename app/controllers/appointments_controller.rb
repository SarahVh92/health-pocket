class AppointmentsController < ApplicationController
  # before_action :set_appointment, only: %i[show]
  def index
    @appointments = policy_scope(Appointment)
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @gcal_service = Gcal.new
    appointment = {
        title: @appointment.title,
        address: @appointment.address,
        start_date: @appointment.start_date,
        description: @appointment.description
      }
    @gcal_service.post_to_gcalendar(appointment, @service)
    authorize @appointment
    @appointment.user = current_user
      if @appointment.save
        redirect_to appointments_path, notice: 'Appointment was successfully created.'

      else
        render :new, status: :unprocessable_entity
      end

    # rescue Google::Apis::ClientError => error
    #   redirect_to appointments_path, notice: error.message
    # end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:title, :start_date, :description, :address)
  end

  # def set_appointment
  #   @appointment = Appointment.find(params[:id])
  # end
end
