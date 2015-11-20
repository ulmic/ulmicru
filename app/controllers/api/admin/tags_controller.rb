class Api::Admin::TagsController < Api::Admin::ApplicationController
  def index
    if params[:record_id].present?
      @tags = Tag.active.where(record_id: params[:record_id], record_type: params[:record_type].capitalize).decorate
    else
      @tags = Tag.string
      @tags = @tags.search_everywhere params[:q] if params[:q]
      @tags = @tags.decorate.to_a.uniq &:text
    end
    # FIXME вывести во вьюху
    tags_presenter = []
    @tags.each do |tag|
      tags_presenter << { id: tag.id, text: tag.just_text }
    end
    render json: tags_presenter
  end

  def create
    @tag_form = TagForm.new_with_model
    @tag_form.submit params[:tag]
    if @tag_form.save
      if @tag_form.tag_type.link?
        render json: { target: @tag_form.model.target,
                       tag_id: @tag_form.model.id,
                       target_type: @tag_form.model.target_type }
      else
        render json: { tag_id: @tag_form.model.id,
                       text: @tag_form.model.text,
                       target_type: 'Tag' }
      end
    else
      head :bad_request
    end
  end

  def destroy
    @tag = Tag.find params[:id]
    @tag.remove
    head :ok
  end
end
