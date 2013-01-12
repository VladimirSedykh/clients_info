class AllRemindersController < ApplicationController
  def index
    db_time = Time.current.in_time_zone('EET')
    @past_reminders = Reminder.not_closed.where("scheduled_time <= '#{db_time.strftime("%Y-%m-%d %H:%M:%S")}'")
    @today_reminders = Reminder.not_closed.where("scheduled_time <= '#{db_time.strftime("%Y-%m-%d 23:59:59")}'")
    respond_to do |format|
      format.html do
        @tomorrow_reminders = Reminder.not_closed.where(<<-EOS
              scheduled_time >= '#{(db_time + 1.day).strftime("%Y-%m-%d 00:00:00")}' AND
              scheduled_time <= '#{(db_time + 1.day).strftime("%Y-%m-%d 23:59:59")}'
            EOS
          )
        @future_reminders = Reminder.not_closed


        @reminders =
        if ["past_reminders", "today_reminders", "future_reminders", "tomorrow_reminders"].include?(params[:type])
          instance_variable_get("@" + params[:type])
        else
          Reminder.all
        end
      end

      format.json do
        messages = @past_reminders.not_showed.map(&:full_info).join("\n ------------------------- \n")
        render :json=> {:past_count => @past_reminders.count, :today_count => @today_reminders.count, :messages => messages, :past_ids => @past_reminders.map(&:id).join(",")}
      end
    end
  end

  def update_viewed
    respond_to do |format|
      format.json do
        ids = params[:ids].split(',').each do |id|
          Reminder.find_by_id(id).try(:update_attributes, {:showed => true})
        end
       render :json=> {}
      end
    end
  end

  def edit
    @reminder = Reminder.find_by_id(params[:id])
  end

  def update
    @reminder = Reminder.find_by_id(params[:id])
    respond_to do |format|
      format.html do
        if @reminder.try(:update_attributes, params[:reminder])
          redirect_to all_reminders_path
        else
          render "edit"
        end
      end

      format.json do
        used = params[:closed] == "checked"
        @reminder.try(:update_attributes, {:closed => used, :showed => used})
        render :json=> {}
      end
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id]).destroy
    redirect_to all_reminders_path
  end
end
