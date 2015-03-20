class MemberDecorator < Draper::Decorator
  delegate_all
  def full_name
    "#{first_name} #{patronymic} #{last_name}"
  end

  def name
    full_name
  end

  def short_name
    "#{first_name} #{last_name}"
  end

  def place
    "#{municipality}, #{locality}"
  end

  def main_post
    for_now_posts = posts.for_now
    return for_now_posts.first.title if for_now_posts.any?
    posts.last_held_post.decorate.post
  end
end
