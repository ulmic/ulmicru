class ArticleDecorator < ApplicationDecorator
  delegate_all

  def short_body
    "#{strip_tags(object.body)[0..50]}..." if object.body
  end

  def description_lead
    "#{model.body.first(200)}..."
  end

  def name
    title
  end

  alias :lead :short_body

  def publicity_icon
    case object.publicity
    when 'visible'
      fa_icon :eye
    when 'access_on_link'
      fa_icon :link
    when 'hidden'
      fa_icon 'eye-slash'
    end
  end

  def access_icon
    case object.access
    when 'all'
      fa_icon :users
    when 'members'
      image_tag configus.organization.logo_transparent, class: 'my-glyphicon' do
      end
    end
  end

  def author_name
    user.decorate.short_name
  end
end
