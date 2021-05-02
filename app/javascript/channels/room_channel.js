import consumer from "./consumer"

  const appRoom = consumer.subscriptions.create("RoomChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
    const current_user = $("#current_user_id").val();
    if (data.message.user == current_user){
      const html =
      `<div class="outgoing-msg" >
        <div class="sent-msg">
          <div class="msg-content">
            ${ data.message.message}
          </div>
          <div class="created-time">
            今
          </div>
        </div>
      </div>`;
      const $messages = document.getElementById('js-messages');
      const $newMessage = document.getElementById('js-input-msg');
      $messages.insertAdjacentHTML('beforeend', html);
      $newMessage.value='';
      const $obj = document.getElementById("js-msg-history");
      $obj.scrollTop = $obj.scrollHeight;
    } else {
        const html =
        `<div class="incoming-msg">
          <div class="img-box">
            <div class="avatar-img">
              <img src= ${data.user_image}  size= "50x50"  class= "img-circle">
            </div>
          </div>
          <div class="partner-info">
            <div class="partner-name">
              ${data.user.nickname}
            </div>
            <div class="received-msg">
              <div class="received_withd_msg">
                ${data.message.message}
              </div>
              <div class="created-time">
                今
              </div>
            </div>
          </div>
        </div>`;
        const $messages = document.getElementById('js-messages');
        const $newMessage = document.getElementById('js-input-msg');
        $messages.insertAdjacentHTML('beforeend', html);
        $newMessage.value='';
        const $obj = document.getElementById("js-msg-history");
        $obj.scrollTop = $obj.scrollHeight;
      };
    }
  });