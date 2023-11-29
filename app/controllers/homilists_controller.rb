# frozen_string_literal: true

# == Schema Information
#
# Table name: homilists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  photo      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class HomilistsController < ApplicationController
  before_action :set_homilist, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create destroy]
  before_action :set_admin_only

  def index
    @homilists = Homilist.all
  end

  def show; end

  def new
    @homilist = Homilist.new
  end

  def edit; end

  def create
    @homilist = Homilist.new(homilist_params)
    if @homilist.save
      redirect_to(@homilist)
    else
      render(:new)
    end
  end

  def update
    if @homilist.update(homilist_params)
      redirect_to(@homilist)
    else
      render(:edit)
    end
  end

  def destroy
    @homilist.destroy
    redirect_to(@homilists, status: :see_other)
  end

  private

  def admin_only
    redirect_to('/') unless user_signed_in && current_user.roles.include?('admin')
  end

  def set_homilist
    @homilist = Homilist.find(params[:id])
  end

  def homilist_params
    params.require(:homilist).permit(:name, :title, :photo, :submit)
  end
end
