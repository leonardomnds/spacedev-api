module Business
  module Users
    class UpdateService
      def initialize(user:, params:)
        @user = user
        @params = params
        @params.delete :is_admin
      end

      def call
        normalize_params
        update_user
        @user
      end

      private

      def update_user
        @user.update!(@params)
        @user.reload
      end
    end
  end
end
