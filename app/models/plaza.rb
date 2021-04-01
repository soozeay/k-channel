class Plaza < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'コスメ' },
    { id: 2, name: '語学' },
    { id: 3, name: '料理' },
    { id: 4, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :articles
end