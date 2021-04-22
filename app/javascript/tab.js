if (document.URL.match( /users/ )) {
  document.addEventListener('DOMContentLoaded', function(){
  const $tab = document.getElementById('js-tab');
  const $nav = document.querySelectorAll('[data-nav]');
  const $content = document.querySelectorAll('[data-content]');
  const ACTIVE_CLASS = 'is-active';
  const navLength = $nav.length;

  const init = () =>{
    $content[0].style.display = 'flex';
  };
  init();
  const hundleClick = (e) =>{
    e.preventDefault();
    const $this = e.target;
    const targetValue = $this.dataset.nav;
    let index = 0;
    while(index < navLength){
      $content[index].style.display = 'none';
      $nav[index].classList.remove(ACTIVE_CLASS);
      index++;
    }
    $tab.querySelectorAll('[data-content="' + targetValue + '"]')[0].style.display = 'flex';
    $nav[targetValue].classList.add(ACTIVE_CLASS);
  };

  let index =0;
  while(index < navLength){
    $nav[index].addEventListener('click', (e) => hundleClick(e));
    index++;
  }
  });
}