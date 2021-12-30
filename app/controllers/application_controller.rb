class ApplicationController < ActionController::API
  include Error::ErrorHandler
  include Auth::EnsureAuthentication
  include Auditable::AuditableRequest
end
