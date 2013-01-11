class RemindersController < ApplicationController
  before_filter :find_client
  before_filter :find_reminder, :only => [:show, :edit, :update, :destroy]

  def new
    @reminder = @client.reminders.build
  end

  def create
    @reminder = @client.reminders.build(params[:reminder])
    if @reminder.save
      redirect_to client_reminders_path(@client)
    else
      render "new"
    end
  end

  def update
    if @reminder.update_attributes(params[:reminder])
      redirect_to client_reminders_path(@client)
    else
      render "edit"
    end
  end

  def destroy
    @reminder.destroy
    redirect_to client_reminders_path(@client)
  end

  private

  def find_client
    @client = Client.find(params[:client_id])
  end

  def find_reminder
    @reminder = @client.reminders.find(params[:id])
  end
end
