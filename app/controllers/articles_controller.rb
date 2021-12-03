class ArticlesController < ApplicationController
    before_action :set_article, only: [:show,:edit,:update,:destroy]
    before_action :require_user,except: [:show,:index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        #byebug
        #article is instance variable!!! the [:id] will be the id parameter from url

    end
    def index
        #@articles=Article.all 
        @articles=Article.paginate(page: params[:page], per_page: 5)

    end
    def create
        
        #render plain: params[:article]  #this is just for  debug , shows json structure 
        #@article = Article.new(params[:article])  #it is not allowed method because of security 
        # we have to whitelist the parameters that comes in 
        @article = Article.new(article_params)
        #render plain: params[:article].inspect  # this is just for debug 
        @article.user  = current_user

      
        if @article.save   # save the record 
        #redirect_to article_path(@article)   # redirect to article show 
            flash[:notice] = "Article was ceated successfully!"
            # this uses a flash helper . Can be notice or alert .
            redirect_to @article  # same as above 
        else
            render 'new'
        
        end

    end
    def new
        @article = Article.new  #this is because the article variable will not exit 
        # when we first open the view form  , just after we sent to create 
    end

    def edit

    end
    def update
      
        if @article.update(article_params)
            flash[:notice]="Article was updated successfully!"
            redirect_to @article
        else
            render 'edit'
        end

    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private 
    def set_article
        @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title,:description,category_ids:[])
    end
    def require_same_user
        if current_user!= @article.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own article!"
        redirect_to @article
        end

    end



end