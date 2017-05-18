class DocumentsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    
    if not @project.completed?
			if @project.submission.present?
				if @project.submission.match('^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$')
					@project.completed = true
					@project.director = 0
					@project.writer = 0
					@project.actor = 0
					@project.cinematographer = 0
					@project.composer = 0
					@project.editor = 0
					@project.makeup = 0
					@project.vfx = 0
					@project.public = false
					@requests = Request.where(project_id: @project.id)
					@requests.each do |r|
						r.destroy
					end
					@project.save
					flash[:success] = "Successfully submitted film URL, thanks :)"
				else
					flash[:danger] = "Invalid URL submitted. Please submit a valid URL."
				end
			end
		end
  end
end
