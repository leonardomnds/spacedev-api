module Business
  module Users
    class DestroyService
      def initialize(user:)
        @user = user
      end

      def call
        destroy_user
        @user
      end

      private

      def destroy_user
        @user.destroy!
      end
    end
  end
end
