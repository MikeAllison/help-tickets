class TopicsController < ApplicationController
	
	before_action :restrict_access
	before_action :find_topic, only: [:show, :edit, :update, :destroy]
	before_action :all_topics_paginated, only: [:new, :create]
	
	def index
	  filter = params[:filter]
	  
	  if filter == 'true'
	    @topics = Topic.all.joins(join_table).order(sort_column + ' ' + sort_direction)
	  else
	    all_topics_paginated
	  end
	end
	
	def show
    redirect_to new_topic_path
  end

	def new
		@topic = Topic.new
	end

	def edit
	end

	def create
		@topic = Topic.new(topic_params)

		if @topic.save
			flash[:success] = "Topic created!"
			redirect_to new_topic_path
		else
      flash.now[:danger] = "There was a problem adding the topic."
			render 'new'
		end
	end

	def update
		if @topic.update_attributes(topic_params)
			flash[:success] = "Topic updated!"
			redirect_to new_topic_path
		else
      flash.now[:danger] = "There was a problem updating the topic."
			render 'edit'
		end
	end

	def destroy
		@topic.destroy
		flash[:success] = "Topic deleted!"
		redirect_to new_topic_path
	end

	private

		def find_topic
			@topic = Topic.find(params[:id])
		end

		def all_topics_paginated
			@topics = Topic.all.joins(join_table).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
		end

		def topic_params
			params.require(:topic).permit(:system)
		end
	
end