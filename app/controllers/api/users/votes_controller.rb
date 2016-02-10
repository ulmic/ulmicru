class Api::Users::VotesController < Api::Users::ApplicationController
  include Concerns::Vote

  def create
    @vote_form = VoteForm.new_with_model
    params[:vote][:difference] = difference_count params[:vote][:difference]
    params[:vote].merge! user_id: current_user.id
    binding.pry
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
    likes = Vote.likes.where(target_type: params[:vote][:target_type],
                       target_id: params[:vote][:target_id]).count
    dislikes = Vote.dislikes.where(target_type: params[:vote][:target_type],
                             target_id: params[:vote][:target_id]).count
    if vote
      render json: { difference: vote.difference, results: { likes: likes, dislikes: dislikes }}
    else
      render json: { results: { likes: likes, dislikes: dislikes } }
    end
  end

  def update
    vote = Vote.where(target_type: params[:vote][:target_type],
                      target_id: params[:vote][:target_id],
                      user_id: current_user.id).first
    params[:vote][:difference] = difference_count params[:vote][:difference]
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
