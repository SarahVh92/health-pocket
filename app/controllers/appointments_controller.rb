class AppointmentsController < ApplicationController
  # before_action :set_appointment, only: %i[show]
  after_action :set_google_appointment, only: %i[ create ]
  def index
    @appointments = policy_scope(Appointment)
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)
    # @gcal_service = Gcal.new
    # appointment = {
    #     title: @appointment.title,
    #     address: @appointment.address,
    #     date: @appointment.date,
    #     description: @appointment.description
    #   }
    # @gcal_service.post_to_gcalendar(appointment, @service)
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
    params.require(:appointment).permit(:title, :date, :description, :address)
  end

  # def set_appointment
  #   @appointment = Appointment.find(params[:id])
  # end

  def set_google_appointment
    @gcal_service = Gcal.new
    appointment = {
        title: @appointment.title,
        address: @appointment.address,
        date: @appointment.date,
        description: @appointment.description
      }
    @gcal_service.post_to_gcalendar(appointment, @service)
  end
end
