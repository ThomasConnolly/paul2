# frozen_string_literal: true

class AgendasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_agenda, only: %i[show edit update destroy]
  before_action :admin_only, only: %i[new create update destroy]

  def show
    @agenda = Agenda.find(params[:id])
    @agenda_items = @agenda.agenda_items.order(:position)
  end

  def index
    @agendas = Agenda.all
  end

  def new
    @agenda = Agenda.new
    @agenda.agenda_items.build
  end

  # GET /agendas/1/edit
  def edit
    @agenda.agenda_items.build if @agenda.agenda_items.blank?
  end

  # POST /agendas or /agendas.json
  def create
    @agenda = Agenda.new(agenda_params)
    @agenda.user_id = current_user.id
    if @agenda.save
      redirect_to(@agenda)
    else
      render(:new)
    end
  end

  def update
    if @agenda.update(agenda_params)
      redirect_to(@agenda)
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  # DELETE /agendas/1 or /agendas/1.json
  def destroy
    @agenda.destroy
    redirect_to(agendas_url)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def admin_only
    return if current_user.roles.include?('admin')

    redirect_to(root_path,
                alert: 'Only admins can do that.')
  end

  def agenda_params
    params.require(:agenda).permit(
      :meeting_date,
      :user_id,
      :draft,
      agenda_items_attributes: %i[id title details position _destroy]
    )
  end
end
