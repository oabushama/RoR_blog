class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :update, :show, :destroy] #How does before_action and only work?
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    #@articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  
  def new
    @article = Article.new
  end
  
  def edit
   # @article = Article.find(params[:id])
  end
  
  def create
    #debugger
    #render plain: params[:article].inspect #this will put the article hash browser view 
    #What is render exactly?
    @article = Article.new(article_params)#white list means remove block for title and description to go from browser to console?.who the hell blocks it!
    #@article.user = User.first
    @article.user = current_user
    
    
    if @article.save
    flash[:success] = "Article was successfully created"   #flash[:notice] what is this a hash or sytanx? I'm Lost!
    redirect_to article_path(@article) ##I dont understand this argument.
    else
      render 'new' #render :new  #what is the difference between render and redirect_to?
    end            #render new goes to what path?
  end
  
  def update
   # @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
   # @article = Article.find(params[:id])
                                           #puts  @article.title # Can i put thing in view template from here?
  end
  def destroy
   # @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
 
  private #What is private?
  
    def set_article
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])#Can you type out the sytanx of the hash and explain the order starting from the top level key?
    end
    
    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own articles"
        redirect_to root_path#how can i redirect to current user show page?
      end
    end

end

