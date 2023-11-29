# frozen_string_literal: true

class FormationTalksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_formation_talk, only: %i[show edit update]

  def index
    @formation_talks = FormationTalk.all
  end

  def show; end

  def new
    @formation_talk = FormationTalk.new
  end

  def edit; end

  def create
    @formation_talk = FormationTalk.new(formation_talk_params)
    if @formation_talk.save
      redirect_to(@formation_talk)
    else
      render(:new)
    end
  end

  def update
    if @formation_talk.update(formation_talk_params)
      redirect_to(@formation_talk)
    else
      render(:new)
    end
  end

  def destroy
    @formation_talk.destroy
    redirect_to(formation_talks_url, status: :see_other)
  end

  private

  def set_formation_talk
    @formation_talk = FormationTalk.find(params[:id])
  end

  def formation_talk_params
    params.require(:formation_talk).permit(:title, :body, :delivered_on, :submit)
  end
end
