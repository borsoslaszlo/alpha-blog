class ArticlesController < ApplicationController
    def show
        #byebug
        @article = Article.find(params[:id])
        #article is instance variable!!! the [:id] will be the id parameter from url
    end
    def index
        @articles=Article.all 
    end
    def create
        #render plain: params[:article]  #this is just for  debug , shows json structure 
        #@article = Article.new(params[:article])  #it is not allowed method because of security 
        # we have to whitelist the parameters that comes in 
        @article = Article.new(params.require(:article).permit(:title,:description))
        #render plain: params[:article].inspect  # this is just for debug 

      
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
        @article = Article.find(params[:id])
    end
    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title,:description))
            flash[:notice]="Article was updated successfully!"
            redirect_to @article
        else
            render 'edit'
        end

    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end


end