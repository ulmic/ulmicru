module Web::Articles::PresentationHelper
  def years_for_text
    if DateTime.now.month - configus.organization.found_date.month > 6
      DateTime.now.year - configus.organization.found_date.year + 1
    else
      DateTime.now.year - configus.organization.found_date.year - 1
    end
  end
end
