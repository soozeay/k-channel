class Plaza < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'エンタメ（연예정보）' },
    { id: 2, name: 'コスメ（코스메틱）' },
    { id: 3, name: '語学（어학）' },
    { id: 4, name: 'グルメ情報（맛집）' },
    { id: 5, name: '日記（일기）' },
    { id: 6, name: 'その他（기타）' }
  ]
  include ActiveHash::Associations
  has_many :articles
end