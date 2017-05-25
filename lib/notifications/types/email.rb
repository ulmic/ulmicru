module Notifications
  module Types
    class Email
      def self.to_send(params)
        case params[:object].class.name
        when 'News'
          NewsMailer.delay.send(params[:theme], params[:object], params[:user])
        when 'Questionary'
          if QuestionaryMailer.respond_to? params[:theme]
            QuestionaryMailer.delay.send(params[:theme], params[:object], params[:user])
          else
            UserMailer.delay.send(params[:theme], params[:object], params[:user])
          end
        when 'Feedback'
          FeedbackMailer.delay.send(params[:theme], params[:object], params[:user])
        when 'ActivityLines::Corporative::OnlineConference::Question'
          ActivityLines::Corporative::OnlineConference::QuestionMailer.delay.send(params[:theme], params[:object], params[:user])
        when 'ActivityLines::Corporative::Confession'
          ActivityLines::Corporative::ConfessionMailer.delay.send(params[:theme], params[:object], params[:user])
        when 'Comment'
          CommentMailer.delay.send(params[:theme], params[:object], params[:user])
        when 'Event'
          EventMailer.delay.send(params[:theme], params[:object], params[:user])
        else
          UserMailer.delay.send(params[:theme], params[:object], params[:user])
        end
      end
    end
  end
end
