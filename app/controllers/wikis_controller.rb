class WikisController < ApplicationController
  #before_action :require_sign_in
  before_action :authenticate_user!
  
  def index
    #@user = current_user
    #@wikis = @user.wikis
    # @wiki = @wikis.new
    @wikis = Wiki.all
    
    @wiki = Wiki.new
    # @wiki.user = @user
    # @wikis << @wiki
  end
  
  def show
    @user = current_user
    @wikis = @user.wikis
    @wiki = @wikis.find(params[:id])
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
    #@wiki.private = params[:wiki][:private]
    @wiki.private = false
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
     #@user = User.find(params[:user_id])
     #@wikis = @user.wikis
     #@wiki = @wikis.find(params[:id])
     @wikis = Wiki.all
     @wiki = Wiki.find(params[:id])
  end
  
  def update
    #@user = current_user
    #@user = User.find(params[:id])
    #@wikis = @user.wikis
    #@wiki = @wikis.find(params[:id])
    #p @wiki
    @wikis = Wiki.all
    @wiki = @wikis.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body  = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    #@wiki.assign_attributes(wiki_params)
    
     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to wikis_path
     else
       flash[:error] = "There was an error saving the Wiki. Please try again."
       render :edit
     end
  end
  
  def destroy
    
    #@user = current_user
    @wiki = Wiki.find(params[:id])

    if @wiki.user == current_user
      
      if @wiki.destroy
        flash[:notice] = "wiki was deleted successfully."
          redirect_to wikis_path
      else
        flash[:error] = "There was an error deleting the wiki."
        render :wikis_path
      end
    else
      flash[:error] = "The owner has to delete it"
      redirect_to wikis_path
    end
  end
   
   private
 
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end
   
end
