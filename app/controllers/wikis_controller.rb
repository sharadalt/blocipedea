class WikisController < ApplicationController
  #before_action :require_sign_in
  before_action :authenticate_user!
  
  def index 
    @user = current_user
    @wikis = @user.wikis
    @wiki = Wiki.new
  end
  
  def show
    @user = current_user
    @wikis = @user.wikis
    @wiki = Wiki.new
  end
  
  def new
    @user = current_user
    @wikis = @user.wikis
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.user = current_user
    
    if @wiki.save
      flash[:notice] = "Wiki  was saved."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
     @user = current_user
     #@user = current_user
     @wikis = @user.wikis
  end
  
  def update
     @user = User.find(params[:user_id])
     @wiki = Wiki.find(params[:id])
    
     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to user_wiki_path(@user, @wiki)
     else
       flash[:error] = "There was an error saving the Wiki. Please try again."
       render :edit
     end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
 
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki}\" was deleted successfully."
        redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end
   
   def authorize_user
     unless current_user || current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to @wiki
     end
   end
end
