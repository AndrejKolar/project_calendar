class Event < ActiveRecord::Base
  validates :title, :total_hours, presence: true
  validates :total_hours, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 24}

  belongs_to :user, inverse_of: :events
  belongs_to :project, inverse_of: :events

  def set_hours(start_time, end_time)
    self.starts_at = start_time
    self.ends_at = end_time

    self.starts_at = self.starts_at.change(hour: 8)
    self.ends_at = self.ends_at.change(hour: 16)
  end

  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => starts_at.rfc822,
      :end => ends_at.rfc822,
      :allDay => self.all_day,
      :color => self.color,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id)
    }
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      columns = ['Title', 'Date', 'Hours', 'Project', 'Starting Time', 'Ending Time', 'Description']
      csv << columns
      all.each do |event|
        csv << [event.title, event.starts_at.to_date, event.total_hours, event.project.name, event.starts_at.strftime("%H:%M"), event.ends_at.strftime("%H:%M"), event.description]
      end
    end
  end

  def days_span
    Date.parse(self.starts_at.to_s)..Date.parse(self.ends_at.to_s)
  end

  def multiple_days?
    self.days_span.count > 1 ? true : false
  end

  def self.search(search)
    if search
      project_id = Project.where(name: search)
      where('title LIKE ? or project_id LIKE ?', "%#{search}%", project_id)
    else
      scoped
    end
  end
end

