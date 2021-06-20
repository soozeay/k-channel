module RoomsHelper

  def find_partner_info(room, current_user)
    if room.entries[0].user_id == current_user.id
      user = User.find(room.entries[1].user_id)
    else
      user = User.find(room.entries[0].user_id)
    end
  end

  def most_new_message_preview(room)
    # 最新メッセージのデータを取得する
    message = room.messages.order(updated_at: :desc).limit(1)
    # 配列から取り出す
    message = message[0]
    # メッセージの有無を判定
    if message.present?
      # メッセージがあれば内容を表示
      tag.p message.message.to_s, class: 'dm_list__content__link__box__message'
    else
      # メッセージがなければ[ まだメッセージはありません ]を表示
      tag.p '[ まだメッセージはありません ]', class: 'dm_list__content__link__box__message'
    end
  end

  def message_time(room)
    message = room.messages.order(updated_at: :desc).limit(1)
    message = message[0]
    time_ago_in_words(message.created_at.to_s)
  end
end
