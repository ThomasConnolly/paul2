# frozen_string_literal: true

class PledgesController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :change_path, only: [:new]
  before_action :set_pledge, only: %i[show edit update destroy]

  def show; end

  def new
    @pledge = Pledge.new
  end

  def create
    @pledge = Pledge.new(pledge_params)
    @pledge.user_id = current_user.id

    if @pledge.save
      redirect_to(pledge_path(@pledge))
    else
      render(:new)
    end
  end

  def edit; end

  def update
    @pledge.update(pledge_params)
    if @pledge.save
      redirect_to(pledge_path(@pledge))
    else
      render(:edit)
    end
  end

  def destroy
    @pledge.destroy
    redirect_to(root_path, notice: 'Your pledge has been canceled.')
  end

  private

  def set_pledge
    @pledge = Pledge.find(params[:id])
  end

  def change_path
    return unless user_signed_in? && current_user.pledge.present?

    redirect_to(pledge_path(current_user.pledge))
  end

  def redirect_to_login
    return if user_signed_in?

    session['user_return_to'] = new_pledge_path
    redirect_to(new_user_registration_path)
  end

  def pledge_params
    params.require(:pledge).permit(%i[amount dollars stripe_id plan_id plan status
                                      submit])
  end
end
