if(document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function() {
    const ImagePreview = document.getElementById('image-preview');

    const createImageHTML = (blob) =>{
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('class', 'preview-image');
      imageElement.appendChild(blobImage);
      ImagePreview.appendChild(imageElement);
    };

    document.getElementById('article-image').addEventListener('change', function(e){
      const imageContent = document.querySelector('img');
      if(imageContent){
        imageContent.remove();
      }
      
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
}