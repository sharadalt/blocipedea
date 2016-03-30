class CollaboratorsController < ApplicationController
   before_action :authenticate_user!
 
   def create
     wiki = Wiki.find(params[:wiki_id])
     collaborator = current_user.collaborators.build(wiki: wiki)
 
     if collaborator.save
       flash[:notice] = "Collaborator created"
     else
       flash[:alert] = "Collaborator creation failed."
     end
     redirect_to wikis_path
   end
   
   def destroy
     wiki = Wiki.find(params[:id])
     collaborator = current_user.collaborators.where(wiki: wiki).create
 
     if collaborator.destroy
       flash[:notice] = "Removed collaborator."
     else
       flash[:alert] = "Collaborator removal failed."
     end
       redirect_to wikis_path
   end
end
