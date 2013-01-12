class AllRemindersController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        @reminders = Reminder.order("closed DESC, updated_at DESC, scheduled_time DESC")
      end

      format.json do
        db_time = Time.current.in_time_zone('EET').strftime("%Y-%m-%d %H:%M:%S")
        count = Reminder.where("(closed = false OR closed IS NULL) AND scheduled_time <= '#{db_time}'").count
        render :json=> {:count => count}
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        used = params[:closed] == "checked"
        Reminder.find_by_id(params[:id]).try(:update_attributes, {:closed => used, :showed => used})
        render :json=> {}
      end
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id]).destroy
    redirect_to all_reminders_path
  end
end
