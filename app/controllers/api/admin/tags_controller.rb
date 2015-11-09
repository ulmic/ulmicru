class Api::Admin::TagsController < Api::Admin::ApplicationController
  def index
    @tags = Tag.string
    @tags = @tags.search_everywhere params[:q] if params[:q]
    @tags = @tags.to_a.uniq &:text
    render json: { model: 'Tag', list: @tags.to_json(only: :text) }
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
