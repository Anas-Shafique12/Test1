class Portfolio < ApplicationRecord
# scope :filterOnTitle, ->(name) { where(portfolios: { title: name }) }

scope :filter_on_title, ->(name) { where("title LIKE ?", "#{name}") if name.present? }
scope :filter_on_subtitle, ->(name) { where("subtitle LIKE ?", "%#{name}%") if name.present? }
end
