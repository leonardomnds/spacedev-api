module Auditable
  module AuditableRequest
    extend ActiveSupport::Concern

    included do
      before_action :set_paper_trail_whodunnit
      before_action :set_paper_trail_controller_info
    end

    def user_for_paper_trail
      @current_user&.id
    end

    def info_for_paper_trail
      {
        remote_ip: request&.remote_ip,
        request_uuid: request&.uuid
      }
    end
  end
end
