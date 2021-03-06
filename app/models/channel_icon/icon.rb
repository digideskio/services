class ChannelIcon::Icon < ActiveRecord::Base
  self.primary_key = 'icon_id'
  belongs_to    :source
  has_many      :callsigns
  has_many      :xmltvids

  validates     :enabled,   :presence => true
  validates     :icon,      :presence => true
  validates     :name,      :presence => true
  validates     :source_id, :presence => true

  scope :name_contains, ->(name) { where("enabled = 1 AND name LIKE ?", "%#{name}%") }
  scope :name_is, ->(name) { where("enabled = 1 AND name = ?", "#{name}") }
  scope :name_startswith, ->(name) { where("enabled = 1 AND name LIKE ?", "#{name}%") }

  def fullUrl
    source = ChannelIcon::Source.find_by_source_id(self.source_id)
    url = source.url + '/' + self.icon
    @fullUrl = url.sub(%r|logo/hires|, 'hires')
  end
  def iconID
    @iconID = self.icon_id.to_s
  end
  def iconName
    @iconName = self.name
  end
end
