class UsersController < Clearance::UsersController

  before_action :require_login, only: [:index,:show]
  
    def index
        @AllUser= User.all
    end

    def show
      @user= current_user
    #this is the profile page for users
    
    end

    def new
      #use new from Clearance
    end

    def create
        @user = user_from_params
        byebug
        if @user.save
          sign_in @user
          redirect_back_or url_after_create
        else
          render template: "users/new"
        end

    end

    def edit
      #this one is a GET, takes to edit form     
      @user=current_user
    end

    def update
      #this is POST, to update the field
      #render back to Profile page
      @user=current_user

      if user_params[:first_name].blank? == false
        @user.update_attribute :first_name, user_params[:first_name]
        @user.save
      end

      if user_params[:last_name].blank? == false
        @user.update_attribute :last_name, user_params[:last_name]
        @user.save
      end

      if user_params[:email].blank? == false
        @user.update_attribute :email, user_params[:email]
        @user.save
      end

      redirect_to @user
    end

    def destroy
      @user=current_user
      @user.destroy
      # takes us to the root
      redirect_to root_path
    end

    private

    #Strong Params

    def user_from_params
        email = user_params.delete(:email)
        password = user_params.delete(:password)
        first_name = user_params.delete(:first_name)
        last_name = user_params.delete(:last_name)
    
        Clearance.configuration.user_model.new(user_params).tap do |user|
          user.email = email
          user.password = password
          user.first_name = first_name
          user.last_name = last_name
        end
      end

    def user_params
      params.require(:user).permit(:first_name,:last_name,:password,:email,:password)
    end


end
