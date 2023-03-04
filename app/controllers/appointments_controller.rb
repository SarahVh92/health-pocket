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
    @appointment = Gcal.new
    authorize @appointment
    begin
      result = service.insert_appointment(CALENDAR_ID, @appointment)
      puts "Appointment created: #{result.title}"
    rescue
      puts "Appointment already exists"
    end
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
