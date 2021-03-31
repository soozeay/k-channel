class Country < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '日本' },
    { id: 2, name: '韓国' }
  ]
  include ActiveHash::Associations
  has_many :users
end