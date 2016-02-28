class TagCollectionDecorator < DefaultCollectionDecorator
  def with_just_text
    with :id, text: -> { just_text }
  end
end
