class ClientsController < ApplicationController
  def index
    @client = Client.new
    @clients = Client.all
  end

  def new
    @client = Client.new(params[:client])
  end

  def create
    @client = Client.create(params[:client])
    redirect_to root_path
  end
end
