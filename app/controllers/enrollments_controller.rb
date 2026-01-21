class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize @enrollment
  end

  def new
    authorize @enrollment
  end

  def create
    authorize @enrollment
  end

  def destroy
    authorize @enrollment
  end
end
