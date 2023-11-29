# frozen_string_literal: true

class AnniversariesController < ApplicationController
  before_action :set_anniversary, only: %i[show destroy]
  before_action :admin_only

  def index
    @anniversaries = Anniversary.all
    # @import = Anniversary::Import.new
  end

  # def import
  #   @import = Anniversary::Import.new anniversary_import_params
  #   if @import.save
  #     redirect_to anniversaries_path, notice: "Imported #{@import.imported_count} anniversaries"
  #   else
  #     @anniversaries = Anniversary.all
  #     flash[:alert] = "There were #{@import.errors.count} errors in your CSV file"
  #     render action: :index
  #   end
  # end

  def show; end

  def create
    @anniversary = Anniversary.new(anniversary_params)
    if @anniversary.save
      redirect_to(@anniversary, notice: 'Anniversary was successfully created.')
    else
      render(:new)
    end
  end

  def destroy
    @anniversary.destroy
    redirect_to(anniversaries_url, status: :see_other,
                                   notice: 'Anniversary was successfully destroyed.')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_anniversary
    @anniversary = Anniversary.find(params[:id])
  end

  # def anniversary_import_params
  #   params.require(:anniversary_import).permit(:file)
  # end

  def admin_only
    redirect_to('/') unless current_user.roles.include?('admin')
  end

  def anniversary_params
    params.require(:anniversary).permit(:salutation, :last_name, :marriage, :yday, :submit)
  end
end
