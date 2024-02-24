module Admin::DashboardsHelper
    def format_created_at(created_at)
      created_at.strftime("%A, %B %d, %Y")
    end
  end