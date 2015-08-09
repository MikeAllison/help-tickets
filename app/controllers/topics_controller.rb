class TopicsController < ApplicationController

	before_action :restrict_to_technicians
	before_action :find_topic, only: [:edit, :update, :hide]
	before_action :find_all_topics, only: [:index, :new, :create]

	def index
	end

	def new
		@topic = Topic.new
	end

	def edit
	end

	def create
		@topic = Topic.new(topic_params)

		if @topic.save
			flash[:success] = 'Topic created!'
			redirect_to new_topic_path
		else
      @topic.errors.any? ? flash[:danger] = 'Please fix the following errors.' : 'There was a problem adding the topic.'
			render 'new'
		end
	end

	def update
		if @topic.update(topic_params)
			flash[:success] = 'Topic updated!'
			redirect_to new_topic_path
		else
      @topic.errors.any? ? flash[:danger] = 'Please fix the following errors.' : 'There was a problem updating the topic.'
			render 'edit'
		end
	end

	def hide
		@topic.update(hidden: true, active: false)
		flash[:success] = 'Topic hidden!'
		redirect_to new_topic_path
	end

	private

		def find_topic
			@topic = Topic.find_by!(slug: params[:id])
		end

		def find_all_topics
      @topics = Topic.not_hidden
      @topics = apply_joins_and_order(@topics)
      @topics = apply_pagination(@topics)
    end

		def topic_params
			params.require(:topic).permit(:name, :active, :hidden)
		end

end
