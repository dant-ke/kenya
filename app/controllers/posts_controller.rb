class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	
	def index
		if params[:category].blank?
			@posts = Post.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@posts = Post.where(category_id:
				@category_id).order("created_at DESC")
		end

		
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:notice] = "Successfully created post!"
			redirect_to post_path(@post)
		else
			flash[:alert] = "Error creating new post!"
			render :new
		end

	end

	def edit
	end

	def update
		if @post.update_attributes(post_params)
			flash[:notice] = "Successfully updated post!"
			redirect_to post_path(@post)
		else
			flash[:alert] = "Error updating post!"
			render :edit
		end
	end

	def destroy
		if @post.destroy
		 flash[:notice] = "Successfully deleted post!"
		 redirect_to posts_path
		else
			flash[:alert] = "Error updating post!"
		end
	end
private
    def post_params
    	params.require(:post).permit(:title, :content, :category_id)
    end

    def find_post
    	@post = Post.find(params[:id])
    end
end
