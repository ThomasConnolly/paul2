# frozen_string_literal: true

class DonationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_donation, only: %i[show edit update destroy]
  before_action :authenticate_admin, only: [:index]

  def index
    @donations = Donation.all
  end

  def show; end

  def new
    @donation = Donation.new
  end

  def edit; end

  def create
    @donation = Donation.new(donation_params)
    @donation.user_id = current_user.id
    if @donation.save
      redirect_to(@donation)
    else
      flash[:errors] = @donation.errors.full_messages
    end
  end

  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html do
          redirect_to(@donation, notice: 'Donation was successfully updated.')
        end
        format.json { render(:show, status: :ok, location: @donation) }
      else
        format.html { render(:edit) }
        format.json { render(json: @donation.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @donation.destroy
    respond_to do |format|
      format.html do
        redirect_to(donations_url, notice: 'Donation was successfully deleted.')
      end
      format.json { head(:no_content) }
    end
  end

  private

  def set_donation
    @donation = Donation.find(params[:id])
  end

  def authenticate_admin
    redirect_to('/') unless current_user&.admin?
  end

  def donation_params
    params.require(:donation).permit(:amount, :memo, :dollars, :stripe_id, :submit)
  end
end
