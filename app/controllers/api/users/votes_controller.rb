class Api::Users::VotesController < Api::Users::ApplicationController
  def create
    @vote_form = VoteForm.new_with_model
    params[:vote].merge! user_id: current_user.id
    if @vote_form.submit params[:vote]
      head :ok
    else
      head :bad_request
    end
  end

  def show
    vote = Vote.where(target_type: params[:vote][:target_type],
                      target_id: params[:vote][:target_id],
                      user_id: current_user.id).first
    vote ? render(json: vote.difference) : head(:not_found)
  end

  def update
    vote = Vote.where(target_type: params[:vote][:target_type],
                      target_id: params[:vote][:target_id],
                      user_id: current_user.id).first
    @vote_form = VoteForm.new vote
    if @vote_form.submit params[:vote]
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    vote = Vote.where(target_type: params[:vote][:target_type],
                      target_id: params[:vote][:target_id],
                      user_id: current_user.id).first
    vote ? (vote.destroy; head(:ok)) : head(:bad_request)
  end
end
