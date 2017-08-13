module Web::Projects::ItWayHelper
  def it_way_activity_lines(collection)
    collection.reduce({}) do |hash, item|
      hash.merge! I18n.t("activerecord.attributes.forms.projects/it_way/v2017/participant_form.activity_lines.#{item}") => item
    end
  end
end
