class Event < ActiveRecord::Base

  belongs_to :user, inverse_of: :events

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
      columns = ['title', 'starts_at', 'ends_at', 'total_hours', 'description']
      csv << columns
      all.each do |product|
        csv << product.attributes.values_at(*columns)
      end
    end
  end

  def days_span
    Date.parse(self.starts_at.to_s)..Date.parse(self.ends_at.to_s)
  end

  def multiple_days?
    self.days_span.count > 1 ? true : false
  end

end

