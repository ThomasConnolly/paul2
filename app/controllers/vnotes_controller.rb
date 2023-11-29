# frozen_string_literal: true

# == Schema Information
#
# Table name: vnotes
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VnotesController < ApplicationController
  before_action :authenticate_user!
  before_action :vestry_only
  before_action :set_vnote, only: %i[show edit update destroy]

  def new
    @vnote = Vnote.new
  end

  def index
    @vnotes = Vnote.includes(:comments).all
    @vnote = Vnote.new
  end

  def show
    @comments = @vnote.comments.order(created_at: :desc)
  end

  def create
    @vnote = current_user.vnotes.build(vnote_params)
    @vnote.save
    redirect_to(vnotes_path(@vnote))
    VnoteMailer.vnote_created(@vnote).deliver_now
  end

  def update
    @vnote.update(vnote_params)
    redirect_to(@vnote, notice: 'message successfully updated.')
  end

  def edit; end

  def destroy
    @vnote.destroy
    redirect_to(vnotes_path, status: :see_other, notice: 'Your post was deleted.')
  end

  private

  def set_vnote
    @vnote = Vnote.find(params[:id])
  end

  def vnote_params
    params.require(:vnote).permit(:title, :content, :submit, :image)
  end

  def vestry_only
    return if current_user.roles.include?('vestry')

    redirect_to(root_path, alert: "You must be a member of St. Paul's
        Vestry to use this function.")
  end
end
