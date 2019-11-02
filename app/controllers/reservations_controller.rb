class ReservationsController < ApplicationController
  
  before_action :set_reserve, only: [:edit, :show]

  def index
    @reservations = Reserve.where("date_start >= ?", Time.zone.now)
  end

  def show
  end

  def new
    @reserve = Reserve.new()
  end

  def edit
  end

  def create
    @reserve = Reserve.new(reserve_params.merge({user: current_user}))
    if @reserve.save
      redirect_to reservations_path, notice: "Reserva criada com sucesso!"
    else
      render :new
    end
  end

  private

  def set_reserve
    @reserve = Reserve.find(params[:id])
  end

  def reserve_params
    params.require(:reserve).permit(:title, :description, :date_start, :date_end)
  end
end
