class RentalsController < ApplicationController
  before_action :set_proxy
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  def index
    @rentals = Rental.all
  end

  def show; end

  def edit; end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)

    respond_to do |format|
      if @rental.create
        format.html { redirect_to rentals_path, notice: "Rental was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to rental_path(params[:id]), notice: "Rental was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @rental.destroy
        format.html { redirect_to rentals_path, notice: "Rental was successfully destroyed." }
      else
        format.html { redirect_to rentals_path, warning: "Rental was not destroyed." }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_proxy
    @rental_proxy = RentalProxy.new
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def rental_params
    params.require(:rental).permit(:name, :daily_rate)
  end
end
