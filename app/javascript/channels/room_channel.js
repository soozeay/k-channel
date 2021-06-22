import consumer from "./consumer"

  const appRoom = consumer.subscriptions.create("RoomChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const current_user = $("#current_user").val();
      const $userIcon = document.getElementById('js-user-icon');
      const $defaultIcon = document.getElementById('js-default-icon');
      const $japanIcon = document.getElementById('js-japan-icon');
      const $koreaIcon = document.getElementById('js-korea-icon');
      function icon(){
        if( $userIcon === null ){
          return $defaultIcon
        } else {
          return $userIcon
        };
      }
      function country_icon(){
        if( $japanIcon === null ){
          return $koreaIcon
        } else {
          return $japanIcon
        };
      }
      if (document.URL.match( /ja/ )) {
        // 添削メッセージが存在しない場合
        if (data.target_message == null) {
          if (data.message.user_id == current_user){
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
                  <img src= "${icon()["src"]}" width="50" height="50" class="img-circle">
                  <div class="country-icon">
                    <img src= "${country_icon()["src"]}" width="20" height="20" class="country-img">
                  </div>
                </div>
              </div>
              <div class="received-msg">
                <div class="received_withd_msg">
                  ${data.message.message}
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
          };
        // 添削メッセージが存在する場合
        } else {
          if (data.message.user_id == current_user){
            const html =
            `<div class="outgoing-msg" >
              <div class="sent-msg">
                <div class="msg-content">
                  <p>× <span>${ data.target_message.message}</span></p>
                  ○${ data.message.message}
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
                  <img src= "${icon()["src"]}" width="50" height="50" class="img-circle">
                  <div class="country-icon">
                    <img src= "${country_icon()["src"]}" width="20" height="20" class="country-img">
                  </div>
                </div>
              </div>
              <div class="received-msg">
                <div class="received_withd_msg">
                  <p>× <span>${data.target_message.message}</span></p>
                  ○${data.message.message}
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
          };
        };
      // 以下韓国語の場合
      } else {
        if (data.target_message == null) {
          if (data.message.user_id == current_user){
            const html =
            `<div class="outgoing-msg" >
              <div class="sent-msg">
                <div class="msg-content">
                  ${ data.message.message}
                </div>
                <div class="created-time">
                  지금
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
                  <img src= "${icon()["src"]}" width="50" height="50" class="img-circle">
                  <div class="country-icon">
                    <img src= "${country_icon()["src"]}" width="20" height="20" class="country-img">
                  </div>
                </div>
              </div>
              <div class="received-msg">
                <div class="received_withd_msg">
                  ${data.message.message}
                </div>
                <div class="created-time">
                  지금
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
        } else {
          if (data.message.user_id == current_user){
            const html =
            `<div class="outgoing-msg" >
              <div class="sent-msg">
                <div class="msg-content">
                  <p>× <span>${ data.target_message.message}</span></p>
                  ○${ data.message.message}
                </div>
                <div class="created-time">
                  지금
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
                  <img src= "${icon()["src"]}" width="50" height="50" class="img-circle">
                  <div class="country-icon">
                    <img src= "${country_icon()["src"]}" width="20" height="20" class="country-img">
                  </div>
                </div>
              </div>
              <div class="received-msg">
                <div class="received_withd_msg">
                  <p>× <span>${data.target_message.message}</span></p>
                  ○${data.message.message}
                </div>
                <div class="created-time">
                  지금
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
        };
      }
    }
  });