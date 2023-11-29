# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :authenticate_user!

  # GET /links/1
  # GET /links/1.json
  def index
    @links = Link.all
    @worship = Link.find_by(event: 'worship')
    @bulletin = Link.find_by(event: 'bulletin')
    @wine = Link.find_by(event: 'wine_time')
    @vestry_meeting = Link.find_by(event: 'vestry_meeting')
  end

  def show
    @link = Link.find(params[:id])
    @worship = Link.find_by(event: 'worship')
    @bulletin = Link.find_by(event: 'bulletin')
    @wine = Link.find_by(event: 'wine_time')
    @vestry_meeting = Link.find_by(event: 'vestry_meeting')
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    redirect_to(@link, notice: 'Link was successfully created.') if @link.save
  end

  def update
    @link = Link.find(params[:id])
    return unless @link.update(link_params)

    redirect_to(@link,
                notice: 'Link was successfully updated.')
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    respond_to do |format|
      format.html do
        redirect_to(links_url, status: :see_other,
                               notice: 'Link was successfully destroyed.')
      end
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:event, :time, :date, :url, :submit)
  end
end
