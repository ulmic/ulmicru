module Web::Admin::Delivery::CampaignsHelper
  def audience_type_collection
    arr = []
    Delivery::Audience.audience_type.values.each_with_index do |v, index|
      arr << [t("enumerize.delivery/audience.audience_type.#{v}"), v] 
    end
    arr
  end
end
