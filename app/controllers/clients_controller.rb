#!/bin/env ruby
# encoding: utf-8
class ClientsController < ApplicationController
  before_filter :find_client, :only => [:show, :edit, :update, :destroy]
  before_filter :init_client, :only => [:new, :create]

  def index
    @client = Client.new
    @clients = Client.by_group(current_group).order(order_params).paginate(:page => params[:page])
  end

  def new
    @client = Client.new
    @contacts = Array.new(2) { @client.contacts.build }
  end

  def edit
    detect_frame
  end

  def search
    @client = Client.new
    @contacts = Array.new(2) { @client.contacts.build }
    session[:params] = params if self.request.post?
    search_params = self.request.get? ? session[:params] : params
    @clients = Client.search(search_params, current_group).paginate(:page => params[:page])
    redirect_to pages_url(top=true)
  end

  def show
    @contact = Contact.new
    detect_frame
  end

  def create
    (params[:contacts] || []).each do |contact_params|
      unless contact_params.values.delete_if(&:blank?).empty?
        @client.contacts.new(contact_params)
      end
    end
    if @client.save
      @client.update_short_contacts
      flash[:notice] = "Запись успешно создана."
      redirect_to root_path
    else
      @contacts = @client.contacts
      @contacts = Array.new(2) { @client.contacts.build } if @contacts.empty?
      @clients = Client.by_group(current_group).paginate(:page => params[:page])
      render :action => "index"
    end
  end

  def update
    @client.update_attributes(params[:client])
    redirect_to client_path(@client)
  end

  def destroy
    @client.destroy
    redirect_to root_path
  end

  def change_group
    session[:group] = params[:group]
    redirect_to root_path
  end

  private

  def init_client
    @client = Client.new(params[:client])
  end

  def find_client
    @client = Client.find(params[:id])
  end

  def order_params
    params[:field] ||= "name"
    params[:direction] ||= "asc"
    "#{params[:field]} #{params[:direction]}"
  end
end
