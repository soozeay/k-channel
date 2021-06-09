document.addEventListener('DOMContentLoaded', function(){
  const $elements = document.querySelectorAll('.plaza-list');
  $elements.forEach( element => {
    const $triggers = element.querySelectorAll('.accordion-nav');
    $triggers.forEach( trigger => {
      trigger.addEventListener('click',(e) => {
        e.preventDefault();
        const $navItems = element.querySelectorAll('.plaza-name');
        $navItems.forEach( navItem => {
          if( navItem.style.display == "none" ) {
            navItem.style.display = "block";
          } else {
            navItem.style.display = "none";
          }
        });
      });
    });
  });
});