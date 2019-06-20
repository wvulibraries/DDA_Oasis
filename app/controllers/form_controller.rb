class FormController < ApplicationController
  include FormHelper

  require 'rest_client'
  require 'json'

  # run a filter with authenticatable concern
  before_action :access_permissions unless Rails.env.test?

  def index
    params[:role] = user_role?
    params[:isbn] = '9781620971994'
  end

  def submit
    response = RestClient.get('https://oasis-services.proquest.com/order/', params: form_params.to_h)
    final_data = JSON.parse(response)

    puts final_data["Code"]

    if final_data["Code"] == 100
      redirect_to '/success'
    else
      render json: response.body
    end
  end

  def success; end

  def error; end

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:item_request)
          .permit(:apiKey,
                  :Oemadm,
                  :Quantity,
                  :ISBN,
                  :Facmemb,
                  :intrdisc,
                  :Oemend,
                  :Site,
                  :Role,
                  :IntNotes)
  end

end
