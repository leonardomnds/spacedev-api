module Reports
  module Clients
    class ClientNumberEvolution
      def initialize(start_date:, end_date:)
        @start_date = (start_date || Time.zone.today.beginning_of_year).to_date.to_s
        @end_date = (end_date || Time.zone.today.end_of_year).to_date.to_s
      end

      def call
        mount_data
      end

      private

      def mount_data
        date_series.map do |serie|
          date = serie['date']

          {
            date: date,
            count: find_client_count(date: date)
          }
        end
      end

      def date_series
        ActiveRecord::Base.connection.execute("
          SELECT
            date::DATE
          FROM
            GENERATE_SERIES(
              '#{@start_date}',
              '#{@end_date}',
              '1 #{interval}'::INTERVAL
            ) AS date
        ")
      end

      def interval
        (@start_date.to_date..@end_date.to_date).count <= 31 ? 'DAY' : 'MONTH'
      end

      def find_client_count(date:)
        date = interval == 'DAY' ? date.to_date.end_of_day : date.to_date.end_of_month

        Client.where('created_at <= ?', date)
              .count
      end
    end
  end
end
