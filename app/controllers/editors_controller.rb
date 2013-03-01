class EditorsController < ApplicationController

  before_filter { |f| f.user_has_perm? 'editor' }

  def index
  end

  def edit
    @tweet = Tweet.find(params[:id])

    unless @tweet.for_editors && @tweet.twitter_id.nil?
      redirect_to authors_url, :alert => "You do not have access to edit this tweet."
    end
  end
  # {{{ def update
  def update
    @tweet = Tweet.find(params[:id])

    unless @tweet.for_editors && @tweet.twitter_id.nil?
      redirect_to authors_url, :alert => "You do not have access to edit this tweet."
    end

    params[:tweet][:editor] = @current_user
    params[:tweet][:tweet] = Correction.autocorrect_all(params[:tweet][:tweet])

    if @tweet.update_attributes(params[:tweet])
      notice = 'Post saved'
      if params[:commit] == 'Publish'
        if @tweet.moderate?
          notice += ' and moderated...'
        elsif @tweet.publish?
          notice += ' and published...'
        end
        @tweet.save
      end
      redirect_to authors_path, :notice => notice
    end
  end
  # }}}

end
