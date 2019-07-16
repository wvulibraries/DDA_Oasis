class ItemRequestController < ApplicationController
  require 'rest_client'
  require 'json'

  # run a filter with authenticatable concern
  before_action :access_permissions, only: [:new, :submit] unless Rails.env.test?

  def index; end

  def new
    @item_request = ItemRequest.new(set_form_fields)
  end

  def submit
    @item_request = ItemRequest.new(item_request_params)

    if @item_request.valid?
      process_request
    else
      render :new
    end
  end

  def success; end

  private

  def set_form_fields
    { 
      Facmemb: session['cas']['extra_attributes']['displayName'],
      intrdisc: session['cas']['extra_attributes']['busoff'],
      Oemend: session['cas']['extra_attributes']['mail'],
      Role: set_user_role
    }
  end

  def set_user_role
    return 'Faculty' if session['cas']['extra_attributes']['isFaculty'] == 'TRUE'
    return 'Staff' if session['cas']['extra_attributes']['isEmployee'] == 'TRUE'
    return 'Undergrad' if session['cas']['extra_attributes']['isStudent'] == 'TRUE'
    'Other'
  end

  def process_request
    final_data = rest_submit

    case final_data['Code']
    when 100
      render :success
    when 200, 400
      flash[:error] = final_data['Message']
    else
      flash[:error] = 'Unable to process request'
    end
    render :new
  end

  def rest_submit
    response = RestClient.get(ENV["OASIS_URL"], params: form_values)

    JSON.parse(response)
  end

  def form_values
    hash = item_request_params.to_h

    # add missing items to the form values
    hash[:apiKey] = ENV['API_KEY']
    hash[:Oemadm] = ENV['ORDER_EMAIL']
    hash[:Quantity] = 1
    hash
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_request_params
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
