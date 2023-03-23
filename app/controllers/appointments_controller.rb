class AppointmentsController < ApplicationController
  after_action :set_google_appointment, only: %i[create]

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
  end

  private

  def appointment_params
    params.require(:appointment).permit(:title, :date, :description, :address)
  end

  def set_google_appointment
    puts @appointment
    if @appointment.title == "" || @appointment.date == nil || @appointment.date == ""
      puts "CALLING RETURN"
      return
    end
    @gcal_service = Gcal.new
    appointment = {
      title: @appointment.title,
      address: @appointment.address,
      date: @appointment.date,
      description: @appointment.description
    }
    puts "TEST_______________________"
    @gcal_service.post_to_gcalendar(appointment, @service)
  end
end
