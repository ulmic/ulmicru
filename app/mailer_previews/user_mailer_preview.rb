class UserMailerPreview
  def after_create
    UserMailer.after_create User.last, User.last
  end

  def just_message
    user = OpenStruct.new email: (@email || 'example@ulmic.ru'), 
			  first_name: (@first_name || 'Leopold'), 
			  last_name: (@last_name || 'Botov')
    @link ||= '/'
    @subject ||= 'EmailPreview'
    @message ||= 'An OpenStruct is a data structure, similar to a Hash, that allows the definition of arbitrary attributes with their accompanying values. This is accomplished by using Ruby’s metaprogramming to define methods on the class itself.'
    @image ||= ActionController::Base.helpers.image_path('pages/contacts/card_background.jpg')
    @subscription_token = '12123456'
    UserMailer.just_message user, @subject, @message, @link, @image, @subscription_token
  end
end
