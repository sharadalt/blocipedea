class CollaboratorsController < ApplicationController
   before_action :authenticate_user!
 
   def create
     wiki = Wiki.find(params[:wiki_id])
     user = User.find(params[:user_id])
     collaborator = wiki.collaborators.build(wiki: wiki, user: user)
 
     if collaborator.save
       flash[:notice] = "Collaborator created."
     else
       flash[:alert] = "Collaborator creation failed."
     end
     redirect_to wikis_path
   end
   
   def destroy
  
     collaborator = Collaborator.find(params[:id])
     #collaborator = wiki.collaborators.find_by(params[:wiki_id] == wiki.id)
     if collaborator.destroy
       flash[:notice] = "Removed collaborator."
     else
       flash[:alert] = "Collaborator removal failed."
     end
     redirect_to wikis_path
   end
end
