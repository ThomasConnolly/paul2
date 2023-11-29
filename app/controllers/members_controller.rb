# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_member, only: %i[show update edit destroy]

  def index
    @members = Member.all.order(:last_name)
    @diaspora = Member.where.not(away_zip: nil).where.not(email: nil)
  end

  def update
    @member.update(member_params)
    @member.save
    redirect_to(members_path)
  end

  def edit; end

  def show; end

  def destroy
    @member.destroy
    redirect_to(members_path, status: :see_other, notice: 'Member successfully deleted')
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:last_name, :first_name, :membership_id, :birthday,
                                   :email, :yday, :away_zip, :submit)
  end
end
