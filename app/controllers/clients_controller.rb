class ClientsController < ApplicationController
  def index
    @client = Client.new
    @clients = Client.all
    @contacts = Array.new(2) { @client.contacts.build }
  end

  def new
    @client = Client.new(params[:client])
  end

  def create
    @client = Client.new(params[:client])
    params[:contacts].each do |contact_params|
      @client.contacts.new(contact_params)
    end
    if @client.save
      @client.update_short_contacts
      redirect_to root_path
    else
      @contacts = @client.contacts
      @clients = Client.all
      render :action => "index"
    end
  end
end
