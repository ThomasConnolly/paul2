# frozen_string_literal: true

class StripeReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  before_action :set_stripe_report, only: :show

  respond_to :html, :js

  def new
    @stripe_report = StripeReport.new
  end

  def create
    @stripe_report = StripeReport.new(params[:stripe_report])
  end

  def index
    @stripe_reports = StripeReport.all
  end

  def show; end

  private

  def set_stripe_report
    @stripe_report = stripe_report.find(params[:id])
  end

  def stripe_report_params
    params.require(:stripe_report).permit(:user_id, :amount, :fee, :net, :donation_id,
                                          :pledge_id, :submit)
  end

  def admin_only
    return if user_signed_in? && current_user.roles.include?('admin')

    redirect_to(root_path,
                alert: 'This information is private.')
  end
end
