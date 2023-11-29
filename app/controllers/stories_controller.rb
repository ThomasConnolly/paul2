# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: %i[show edit update destroy]

  # GET /stories or /stories.json
  def index
    @stories = Story.all
  end

  # GET /stories/1 or /stories/1.json
  def show; end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit; end

  # POST /stories or /stories.json
  def create
    @story = Story.new(story_params)
    @story.user_id = current_user.id
    if @story.save
      redirect_to(story_url(@story), notice: 'Story was successfully created.')
    else
      render(:new)
    end
  end

  # PATCH/PUT /stories/1 or /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html do
          redirect_to(story_url(@story), notice: 'Story was successfully updated.')
        end
        format.json { render(:show, status: :ok, location: @story) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @story.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /stories/1 or /stories/1.json
  def destroy
    @story.destroy

    respond_to do |format|
      format.html do
        redirect_to(stories_url, status: :see_other,
                                 notice: 'Story was successfully destroyed.')
      end
      format.json { head(:no_content) }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_story
    @story = Story.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def story_params
    params.require(:story).permit(:title, :user_id, :status, :body, :submit)
  end
end
