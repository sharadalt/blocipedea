class WikisController < ApplicationController
  
  after_action :verify_authorized, except: [:index, :downgrade]
  after_action :verify_policy_scoped, only: :index
  
  before_action :authenticate_user!
  
  def index
    #@wikis = Wiki.all
    @wikis = policy_scope(Wiki)
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    @wiki = @wikis.new
    @wiki.title = params[:wiki][:title]
    @wiki.body  = params[:wiki][:body]
    if current_user.premium?
      @wiki.private  = params[:wiki][:private]
    else
      @wiki.private = false
    end
    @wiki.user = @user
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki  was saved."
      redirect_to user_wikis_path(@user)
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wikis = Wiki.all
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
  def update
    @wikis = Wiki.all
    @wiki = @wikis.find(params[:id])
    authorize @wiki
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
    @wiki = Wiki.find(params[:id])
    authorize @wiki

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
  
  def downgrade
    current_user.role = :standard
    p current_user.role
    redirect_to wikis_path
    current_user.save
  end
   
   private
 
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end
   
end
