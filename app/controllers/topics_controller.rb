class TopicsController < ApplicationController
	
	before_action :find_topic, only: [:edit, :update, :destroy]
	
	def index
		@topics = Topic.all
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
			redirect_to topics_path
		else
			render 'new'
		end
	end

	def update
		if @topic.update_attributes(topic_params)
			flash[:success] = "Topic updated!"
			redirect_to topics_path
		else
			render 'edit'
		end
	end

	def destroy
		@topic.destroy
	end

	private

		def find_topic
			@topic = Topic.find(params[:id])
		end

		def topic_params
			params.require(:topic).permit(:system)
		end
	
end