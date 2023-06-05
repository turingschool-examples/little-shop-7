class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def format_time_stamp
    created_at.strftime('%A, %B %e, %Y')
  end
end
