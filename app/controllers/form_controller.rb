class FormController < ApplicationController
  include FormHelper

  require 'rest_client'
  require 'json'

  # run a filter with authenticatable concern
  before_action :access_permissions, only: [:create, :submit] unless Rails.env.test?

  def index; end

  def create
    params[:role] = user_role?
  end

  def submit
    redirect_to root_path, error: 'Missing ISBN' and return if form_params[:ISBN].blank?
    redirect_to root_path, error: 'Please Select a Site Location' and return if form_params[:Site].blank?

    response = RestClient.get(ENV["OASIS_URL"], params: form_values)

    final_data = JSON.parse(response)

    case final_data['Code']
    when 100
      redirect_to '/success'
    when 200, 400
      redirect_to :form_create, error: final_data['Message']
    else
      redirect_to :form_create, error: 'Unable to process request'
    end
  end

  def success; end

  def form_values
    hash = form_params.to_h

    # add missing items to the form values
    hash[:apiKey] = ENV['API_KEY']
    hash[:Oemadm] = ENV['ORDER_EMAIL']
    hash[:Quantity] = 1
    hash
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:item_request)
          .permit(:ISBN,
                  :Facmemb,
                  :intrdisc,
                  :Oemend,
                  :Site,
                  :Role,
                  :IntNotes)
  end

end
