class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :blog_display, only: [:new, :edit, :show, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    # 新規画面を表示させる
    # 入力された値をcreateに送る

    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    # 入力された値を元にレコードを新規追加する
    # 新規画面を再度表示させる（newにリダイレクトさせる）
    # Blog.create(title: params[:blog][:title], content: params[:blog][:content]) # ハッシュの書き方
    # Blog.create(params[:blog])
    # Blog.create(params.require(:blog).permit(:title, :content))
    # Blog.create(blog_params)
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidを、blogのuser_idカラムに挿入する。外部キー（user_id）に値を入れないとエラーになるから。
    if @blog.save
      redirect_to blogs_path, notice: "ブログを作成しました！" # _pathは相対パス、_urlは絶対パス

      # ActionMailerを呼び出し。メール送信機能追加。
      BlogMailer.blog_mail(@blog).deliver
    else
      render 'new' #リダイレクトにすると入力データが消えるからrenderにする。
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidを、blogのuser_idカラムに挿入する。外部キー（user_id）に値を入れないとエラーになるから。
    render :new if @blog.invalid?
  end

  def show
    # @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    # @blog = Blog.find(params[:id])
  end

  def update
    # @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    # idをキーとして値を取得するメソッド
    @blog = Blog.find(params[:id])
  end

  def blog_display
    unless logged_in? # ApplicationControllerに記述してある。
      redirect_to new_session_path
    end
  end
end
