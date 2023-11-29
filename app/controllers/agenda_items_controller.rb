# frozen_string_literal: true

class AgendaItemsController < ApplicationController
  def index
    @agenda_items = AgendaItem.order(:position)
  end

  def show; end

  def new
    @agenda_item = AgendaItem.new
  end

  def create
    @agenda = Agenda.find(params[:agenda_id])
    @agenda_item = @agenda.agenda_items.create(agenda_items_params)
    @agenda_item.position = (@agenda.agenda_items.maximum(:position) || 0) + 1
    if @agenda_item.save
      redirect_to(@agenda)
    else
      render(:new)
    end
  end

  def edit
    render(_form)
  end

  def update_position
    @agenda_item = AgendaItem.find(params[:id])
    @agenda_item.insert_at(agenda_item_params[:position].to_i)
    head(:ok)
  end

  def destroy
    @agenda = Agenda.find(params[:agenda_id])
    @agenda_item = @agenda.agenda_items.find(params[:id])
    @agenda_item.destroy
    redirect_to(@agenda)
  end

  private

  def agenda_items_params
    params.require(:agenda_item).permit(:title, :position, :details)
  end
end
