class ProductsController < ApplicationController
def new
		#@category = []
		#@user = []
		@product = Product.new
	end

	def index
		@products = Product.all
	end

	def create
		@product = Product.new(product_params)
       if @product.save
       	flash[:notice] = "product Saved Successfully"
       	redirect_to :controller => "products", :action => "product_list"
       else
       	flash[:notice] = "Error"
       	render "new"
       end
	end
            
	def edit
		@product = Product.find(params[:id])
	end

	def destroy
	end

	def show
		
	end

	def product_list
		#@product = Product.find(params[:id])
		@product = Product.where(params[:id]).all
        render :partial => "product", :object => @product
	end

	def update_users
    product = Product.find(params[:user_id])
     @user = User.find(:all,:conditions => ["product_id = ?", product.id])
        
        #district = District.find(:all,:conditions=>["state_id = ?",state.id])
        #@area = Area.find(:all,:conditions=>["district_id = ?", district.id])
        #@state = State.find_all_by_country_id(category.id)
        render :update do |page|
             page.replace_html 'user_order1', :partial => 'user_order', :object => @user
        end
   end

   def update_category
       product = Product.find(params[:cat_id])
       @cat = Category.find(:all,:conditions => ["product_id = ?", product.id]) 
       
       render :update do |page|
        page.replace_html 'cat_order1', :partial => 'cat_order', :object => @cat
       end
   end 
	
	private
	def product_params
		params.require(:product).permit(:user_id,:cat_id,:name,:cost)
	end
end
