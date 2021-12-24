module Business
  module Users
    class CreateService
      def initialize(params:)
        @params = params
        @params.delete :is_admin
      end

      def call
        activate_user
        create_user
        @user
      end

      private

      def create_user
        @user = User.create!(@params)
      end

      def activate_user
        @params[:active] = true
      end
    end
  end
end
