# frozen_string_literal: true

# == Schema Information
#
# Table name: sermons
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  cites        :string(255)
#  sermon_body  :text
#  created_at   :datetime
#  updated_at   :datetime
#  homilist_id  :integer
#  delivered_on :date
#

class SermonsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_sermon, only: %i[show edit update destroy]

  def index
    @sermons = Sermon.all.order('delivered_on DESC')
  end

  def show; end

  def new
    @sermon = Sermon.new
  end

  def edit; end

  def create
    @sermon = Sermon.new(sermon_params)

    respond_to do |format|
      if @sermon.save
        format.html { redirect_to(@sermon, notice: 'Sermon was successfully created') }
      else
        format.html { render(:new) }
      end
    end
  end

  def update
    redirect_to(@sermon) if @sermon.update(sermon_params)
  end

  def destroy
    @sermon.destroy
    redirect_to(sermons_url, status: :see_other)
  end

  private

  def set_sermon
    @sermon = Sermon.find(params[:id])
  end

  def sermon_params
    params.require(:sermon).permit(
      :title,
      :cites,
      :delivered_on,
      :sermon_body,
      :content,
      :homilist_id,
      :audio,
      :submit
    )
  end
end
