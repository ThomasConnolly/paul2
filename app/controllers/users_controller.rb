# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  username              :string(255)
#  role                   :integer
#  stripe_customer_id     :string
#  member_id              :integer
#

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, only: %i[index new create]
  before_action :set_user, only: %i[show edit update destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.all.order(:last_name)
    redirect_to('/') unless current_user.roles.include?('admin')
  end

  def show; end

  def create
    @user = User.new(user_params)
    WelcomeMailer.welcome_email(@user).deliver_now if @user.save
  end

  def update
    redirect_to(profile_path(current_user.profile)) if @user.update(user_params)
  end

  def edit; end

  # DELETE
  def destroy
    @user.delete
    redirect_to(users_path, status: :see_other)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :avatar,
      :stripe_id,
      :stripe_pledge_id,
      :submit,
      roles: []
    )
  end

  def admin_only
    redirect_to(root_path, alert: 'Access is restricted.') unless
    current_user.roles.include?('admin')
  end
end
