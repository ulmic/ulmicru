class Api::Admin::Delivery::ContactEmailsController < Api::Admin::ApplicationController
  def create
    binding.pry
    collection = ::XlsParser.first_sheet_collection params[:file]
    collection.each do |item|
      Delivery::ContactEmail.create first_name: item[0], last_name: item[1], email: item[2]
    end
    head :ok
  end
end
