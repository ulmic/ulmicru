class TagCollectionDecorator < Draper::CollectionDecorator
  def with_just_text
    tags = []
    object.each do |tag|
      tags << { id: tag.id, text: tag.just_text }
    end
    tags
  end
end
