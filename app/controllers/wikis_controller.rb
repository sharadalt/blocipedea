class WikisController < ApplicationController
  #before_action :require_sign_in
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @wikis = @user.wikis
    # @wiki = @wikis.new
    
    @wiki = Wiki.new
    # @wiki.user = @user
    # @wikis << @wiki
    p @wiki
  end
  
  def show
    @user = current_user
    @wikis = @user.wikis
    @wiki = @wikis.find(params[:id])
    #redirect_to user_wiki_path
  end
  
  def new
    @user = current_user
    @wikis = @user.wikis
    @wiki = Wiki.new
    @wiki.user = @user
  end

  def create
    
    @user = current_user
    @wikis = @user.wikis
    #@wiki = Wiki.new(wiki_params)
    #@wiki = Wiki.new
    @wiki = @wikis.new
    @wiki.title = params[:wiki][:title]
    @wiki.body  = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = @user
    
    if @wiki.save
      flash[:notice] = "Wiki  was saved."
      redirect_to user_wikis_path(@user)
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
     #@user = current_user
     @user = User.find(params[:user_id])
     @wikis = @user.wikis
     @wiki = @wikis.find(params[:id])
     p "*************"
     p @wiki
     #render edit_user_wiki_path
  end
  
  def update
    @user = current_user
    #@user = User.find(params[:id])
    @wikis = @user.wikis
    @wiki = @wikis.find(params[:id])
    p @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body  = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    #@wiki.assign_attributes(wiki_params)
    
     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to user_wikis_path
     else
       flash[:error] = "There was an error saving the Wiki. Please try again."
       render :edit
     end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
 
    if @wiki.destroy
      flash[:notice] = "wiki was deleted successfully."
        redirect_to user_wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :user_wikis_path
    end
  end
   
   private
 
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end
   
end
