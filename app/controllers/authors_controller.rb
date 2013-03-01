class AuthorsController < ApplicationController

  before_filter { |f| f.user_has_perm? 'author' }

  def index
  end

  def new
    @tweet = Tweet.new
  end

  def edit
    @tweet = Tweet.find(params[:id])

    if @tweet.for_editors || @tweet.author != @current_user || !@tweet.twitter_id.nil?
      redirect_to authors_url, :alert => "You do not have access to edit this tweet."
    end
  end
  # {{{ def create
  def create
    begin
      params[:tweet][:tweet] = Correction.autocorrect_all(params[:tweet][:tweet])
      params[:tweet][:author] = @current_user
      @tweet = Tweet.new(params[:tweet])

      if @tweet.save
        notice = 'Post saved'

        if params[:commit] == 'Publish'

          if @tweet.moderate?
            notice += ' and moderated...'
          elsif @tweet.publish?
            notice += ' and published...'
          end

          @tweet.save
        end

        redirect_to authors_url, :notice => notice
      else
        render 'new'
      end

    rescue ActiveRecord::RecordNotFound
      flash.now.alert = 'Author was not found when creating tweet'
      redirect_to root_url
    end
  end
  # }}}
  # {{{ def update
  def update
    @tweet = Tweet.find(params[:id])

    if @tweet.for_editors || @tweet.author != @current_user || !@tweet.twitter_id.nil?
      redirect_to authors_url, :alert => "You do not have access to edit this tweet."
    end

    params[:tweet][:author] = @current_user
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
