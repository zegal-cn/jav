class ActressesController < ApplicationController
  before_action :set_actress, only: [:show, :edit, :update, :destroy]
  
  def index
    @actresses = Actress.paginate(:page => params[:page])
    render json: @actresses
  end

  def show
    render json: @actress
  end

  def new
    @actress = Actress.new
  end

  def edit
  end

  def fresh
    @actresses = Actress.fresh
    render json: @actresses
  end

  def count
    render json: Actress.count
  end

  def create
    @actress = Actress.new(actress_params)
    if @actress.save
      render json: @actress
    else
      render json: @actress.errors, status: :unprocessable_entity
    end
  end

  def update
    if @actress.update(actress_params)
      render json: @actress 
    else
      render json: @actress.errors, status: :unprocessable_entity 
    end
  end

  def destroy
    @actress.destroy
    head :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_actress
    @actress = Actress.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def actress_params
    params.require(:actress).permit(:name, :category, :logo, :description)
  end
end