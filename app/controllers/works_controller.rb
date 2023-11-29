# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :set_work, only: %i[show edit update destroy]

  def index
    @works = Work.all
    @work = Work.new
  end

  def show; end

  def new
    @work = Work.new
  end

  def edit; end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to(root_path(anchor: 'top'),
                  notice: 'Thanks, and may God bless your work.')
    else
      render(:new)
    end
  end

  def update
    if @work.update(work_params)
      redirect_to(@work, notice: 'Work was successfully updated.')
    else
      render(:edit)
    end
  end

  # DELETE /marriage_talks/1
  # DELETE /marriage_talks/1.json
  def destroy
    @work.destroy
    redirect_to(works_url)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_work
    @work = Work.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the "permit" through.
  def work_params
    params.require(:work).permit(:my_act, :honey, :submit)
  end
end
