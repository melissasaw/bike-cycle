class UsersController < Clearance::UsersController


    def index
        @user= User.all
    end

    def new
    end

    def create
        byebug
    end

    def edit
    end

    def update
    end

    def destroy
    end

end
