class ItemRequest
  include ActiveModel::Model

  attr_accessor(
    :ISBN,
    :Facmemb,
    :intrdisc,
    :Oemend,
    :Site,
    :Role,
    :IntNotes
  )

  validates :ISBN, presence: true
  validates :Facmemb, presence: true
  validates :intrdisc, presence: true
  validates :Oemend, presence: true
  validates :Site, presence: true
  validates :Role, presence: true

end
