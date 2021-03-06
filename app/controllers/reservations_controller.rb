class ReservationsController < ApplicationController
  
  before_action :set_reserve, only: [:edit, :show, :update, :destroy]

  def index
    @reservations = Reserve.where("date_start >= ?", Time.zone.now).order(:date_start)
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
    @reserve.date_start = date_start
    @reserve.date_end = date_end
    if @reserve.valid? && @reserve.save
      redirect_to reservations_path, notice: "Reserva criada com sucesso!"
    else
      render :new, { errors: @reserve.errors }
    end
  end
  
  def update
    if @reserve.update(reserve_params)
      redirect_to reservations_path, notice: "Reserva atualizada com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if user_permit
      @reserve.destroy
      redirect_to reservations_url, notice: "Reserva excluída com sucesso!"    
    else
      render :show, { errors: "Não pertence a esse usuário"}
    end
  end

  private

  def set_reserve
    @reserve = Reserve.find(params[:id])
  end

  def reserve_params
    params.require(:reserve).permit(:title, :description)
  end

  def date_start
    reserve = params.require(:reserve).permit(:date, :start)
    Time.zone.parse("#{reserve[:date]} #{reserve[:start]}")
  end

  def date_end
    reserve = params.require(:reserve).permit(:date, :end)
    Time.zone.parse("#{reserve[:date]} #{reserve[:end]}")
  end

  def user_permit(reserve)
    reserve.user.id == current_user.id
  end
end
