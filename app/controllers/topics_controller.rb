class TopicsController < ApplicationController
	
	before_action :find_topic, only: [:show, :edit, :update, :destroy]
	
	def index
		@topics = Topic.all.order(:system).paginate(:page => params[:page])
		@topic = Topic.new
	end

	def new
		redirect_to topics_path
	end

	def edit
	end

	def create
		@topic = Topic.new(topic_params)

		if @topic.save
			flash[:success] = "Topic created!"
			redirect_to topics_path
		else
      flash.now[:danger] = "There was a problem adding the topic."
			render 'new'
		end
	end

	def update
		if @topic.update_attributes(topic_params)
			flash[:success] = "Topic updated!"
			redirect_to topics_path
		else
      flash.now[:danger] = "There was a problem updating the topic."
			render 'edit'
		end
	end

	def destroy
		@topic.destroy
		redirect_to topics_path
	end

	private

		def find_topic
			@topic = Topic.find(params[:id])
		end

		def topic_params
			params.require(:topic).permit(:system)
		end
	
end