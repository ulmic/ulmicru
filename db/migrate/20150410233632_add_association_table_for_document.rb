class AddAssociationTableForDocument < ActiveRecord::Migration
  def change
    create_table :articles_documents, id: false do |t|
      t.belongs_to :article, index: true
      t.belongs_to :document, index: true
    end

    create_table :documents_news, id: false do |t|
      t.belongs_to :news, index: true
      t.belongs_to :document, index: true
    end
  end
end
