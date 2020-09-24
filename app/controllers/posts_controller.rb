class PostsController < ApplicationController

  def new
    @post = current_user.posts.build if logged_in?
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "投稿しました!"
      redirect_to posts_path
    else
      flash[:danger] ="投稿できませんでした"
      render 'statics/home'
    end
  end

  def pay
    Payjp.api_key = 'sk_test_c62fade9d045b54cd76d7036'
    charge = Payjp::Charge.create(
      :amount => 500,
      :card => params['payjp-token'],
      :currency => 'jpy',
    )
    user = User.find(params[:id])
    flash[:success] = "相手のemailは#{user.email}です！コンタクトを取ってみましょう！"
    redirect_to user_path(current_user)
  end

  def show
    @post = current_user.posts.find_by(id: params[:id])
  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 6)
  end
  
  private

    def post_params
      params.require(:post).permit(:content, :price, :picture)
    end

end
