# frozen_string_literal: true

class PathwaysController < ApplicationController
  before_action :set_pathway, only: %i[show edit update destroy]

  def index
    @pathways = Pathway.all.order('pubdate DESC')
  end

  def edit; end

  def show; end

  def new
    @pathway = Pathway.new
  end

  def create
    @pathway = Pathway.new(pathway_params)
    if @pathway.save

      redirect_to(pathways_path)
      PathwaysMailer.pathways_created(@pathway).deliver_now
    else
      render(:new)
    end
  end

  def update
    if @pathway.update(pathway_params)
      redirect_to(@pathway)
    else
      render(:edit)
    end
  end

  def destroy
    @pathway.destroy
    redirect_to('/', status: :see_other)
  end

  private

  def set_pathway
    @pathway = Pathway.find(params[:id])
  end

  def pathway_params
    params.require(:pathway).permit(:image, :link, :pubdate, :submit)
  end
end
