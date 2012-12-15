class StoriesController < ApplicationController
  layout "history"

  before_filter :find_client
  before_filter :find_story, :only => [:show, :edit, :update, :destroy]

  def new
    @story = @client.stories.build
  end

  def create
    @story = @client.stories.build(params[:story])
    if @story.save
      redirect_to client_stories_path(@client)
    else
      render "new"
    end
  end

  def update
    if @story.update_attributes(params[:story])
      redirect_to client_stories_path(@client)
    else
      render "edit"
    end
  end

  def destroy
    @story.destroy
    redirect_to client_stories_path(@client)
  end

  private

  def find_client
    @client = Client.find(params[:client_id])
  end

  def find_story
    @story = @client.stories.find(params[:id])
  end
end
