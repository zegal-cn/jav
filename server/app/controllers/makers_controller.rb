class MakersController < ApplicationController
  before_action :set_maker, only: [:show, :edit, :update, :destroy]
  
  def index
    makers = Maker.all
    makers = makers.where("name LIKE '%#{params[:query]}%'") if params[:query]
    makers = makers.paginate(:page => params[:page])
    total = makers.count
    render json: { total: total, list: makers }
  end

  def show
    render json: @maker
  end

  def new
    @maker = Maker.new
  end

  def edit
  end

  def fresh
    @makers = Maker.fresh
    render json: @makers
  end

  def count
    render json: Maker.count
  end

  def create
    @maker = Maker.new(maker_params)
    if @maker.save
      render json: @maker
    else
      render json: @maker.errors, status: :unprocessable_entity
    end
  end

  def update
    if @maker.update(maker_params)
      render json: @maker 
    else
      render json: @maker.errors, status: :unprocessable_entity 
    end
  end

  def destroy
    @maker.destroy
    head :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_maker
    @maker = Maker.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def maker_params
    p "params: #{params}"
    params.require(:maker).permit(:name, :name_cn, :name_en, :rate, :logo, :description)
  end
end