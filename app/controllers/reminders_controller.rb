class RemindersController < ApplicationController
  before_filter :find_client
  before_filter :find_reminder, :only => [:show, :edit, :update, :destroy]
  layout "history"

  def index
    @reminders = @client.reminders.order("reminders.closed DESC, reminders.updated_at DESC, reminders.scheduled_time DESC")
  end

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
    respond_to do |format|
      format.html do
        if @reminder.update_attributes(params[:reminder])
          redirect_to client_reminders_path(@client)
        else
          render "edit"
        end
      end

      format.json do
        used = params[:closed] == "checked"
        Reminder.find_by_id(params[:id]).try(:update_attributes, {:closed => used, :showed => used})
        render :json=> {}
      end
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
