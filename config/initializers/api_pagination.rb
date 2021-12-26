ApiPagination.configure do |config|
  config.paginator = :will_paginate
  config.page_header = 'X-Page'
  config.total_header = 'X-Total'
  config.per_page_header = 'X-Per-Page'
  config.include_total = true
end

WillPaginate.per_page = 20
