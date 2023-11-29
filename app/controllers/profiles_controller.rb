# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  cities     :string(255)
#  background :text
#  career     :text
#  family     :text
#  lifestyle  :text
#  civic      :text
#  church     :text
#  created_at :datetime
#  updated_at :datetime
#

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show edit update]

  def edit; end

  def show; end

  def update
    @profile.update(profile_params)
    if @profile.save
      redirect_to(profile_path(@profile))
    else
      render('edit')
    end
  end

  def index
    @profiles = Profile.all
    @profile = Profile.find(current_user.profile.id)
    @users = User.order(:last_name)
  end

  def new; end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to(current_user_path)
    else
      render('new')
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:cities, :background, :career, :family, :lifestyle,
                                    :civic, :church, :submit)
  end
end
