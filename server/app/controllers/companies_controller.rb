class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.paginate(:page => params[:page])
    render json: @companies
  end

  def show
    render json: @company
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def fresh
    @companies = Company.fresh
    render json: @companies
  end

  def count
    render json: Company.count
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      render json: @company 
    else
      render json: @company.errors, status: :unprocessable_entity 
    end
  end

  def destroy
    @company.destroy
    head :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :category, :logo, :description)
  end
end