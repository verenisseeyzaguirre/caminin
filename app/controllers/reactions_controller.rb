class ReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.reactions.create!(
      user: current_user,
      kind: params[:kind]
    )
    redirect_to posts_path
  end
  
  def destroy
  end
end
