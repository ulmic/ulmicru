class Api::Users::VotesController < Api::Users::ApplicationController
  def create
    @vote_form = VoteForm.new_with_model
    if @vote_form.submit params[:vote]
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @vote = Vote.find params[:id]
    @vote.destroy
    head :ok
  end
end
