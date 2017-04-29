class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show; end

  def edit; end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.create
        format.html { redirect_to bookings_path, notice: "Booking was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to booking_path(params[:id]), notice: "Booking was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @booking.destroy
        format.html { redirect_to bookings_path, notice: "Booking was successfully destroyed." }
      else
        format.html { redirect_to bookings_path, warning: "Booking was not destroyed." }
      end
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def booking_params
    params.require(:booking).permit(:client_email, :start_at, :end_at, :rental_id)
  end
end
