class Plaza < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'エンタメ' },
    { id: 2, name: 'コスメ' },
    { id: 3, name: '語学' },
    { id: 4, name: 'グルメ情報' },
    { id: 5, name: '日記' },
    { id: 4, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :articles
end