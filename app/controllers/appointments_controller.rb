class AppointmentsController < ApplicationController
  def show
    @appointments = current_user.appointments
  end

  def new
    @appointments = Appointment.new
  end
end
