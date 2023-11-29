# frozen_string_literal: true

class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: %i[show edit update destroy]

  # GET /todo_lists
  # GET /todo_lists.json
  def index
    @todo_lists = TodoList.all
  end

  # GET /todo_lists/1
  # GET /todo_lists/1.json
  def show; end

  # GET /todo_lists/new
  def new
    @todo_list = TodoList.new
    @todo_list.user = current_user
  end

  # GET /todo_lists/1/edit
  def edit; end

  # POST /todo_lists
  # POST /todo_lists.json
  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      redirect_to(@todo_list, notice: 'Todo list was successfully created.')
    else
      render(:new)
    end
  end

  # PATCH/PUT /todo_lists/1
  # PATCH/PUT /todo_lists/1.json
  def update
    if @todo_list.update(todo_list_params)
      redirect_to(@todo_list, notice: 'Todo list was successfully updated.')
    else
      render(:edit)
    end
  end

  # DELETE /todo_lists/1
  # DELETE /todo_lists/1.json
  def destroy
    @todo_list.destroy
    redirect_to(todo_lists_url)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the "permit" through.
  def todo_list_params
    params.require(:todo_list).permit(:title, :user_id, :description, :submit)
  end
end
