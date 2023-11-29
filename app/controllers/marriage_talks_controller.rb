# frozen_string_literal: true

class MarriageTalksController < ApplicationController
  before_action :set_marriage_talk, only: %i[show edit update destroy]

  # GET /marriage_talks
  # GET /marriage_talks.json
  def index
    @marriage_talks = MarriageTalk.all
  end

  # GET /marriage_talks/1
  # GET /marriage_talks/1.json
  def show; end

  # GET /marriage_talks/new
  def new
    @marriage_talk = MarriageTalk.new
  end

  # GET /marriage_talks/1/edit
  def edit; end

  # POST /marriage_talks
  # POST /marriage_talks.json
  def create
    @marriage_talk = MarriageTalk.new(marriage_talk_params)
    if @marriage_talk.save
      redirect_to(@marriage_talk, notice: 'Marriage talk was successfully created.')
    else
      render(:new)
    end
  end

  # PATCH/PUT /marriage_talks/1
  # PATCH/PUT /marriage_talks/1.json
  def update
    if @marriage_talk.update(marriage_talk_params)
      redirect_to(@marriage_talk, notice: 'Marriage talk was successfully updated.')
    else
      render(:edit)
    end
  end

  # DELETE /marriage_talks/1
  # DELETE /marriage_talks/1.json
  def destroy
    @marriage_talk.destroy
    redirect_to(marriage_talks_url)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_marriage_talk
    @marriage_talk = MarriageTalk.find(params[:id])
  end

  def marriage_talk_params
    params.require(:marriage_talk).permit(:title, :body, :delivered_on, :submit)
  end
end
