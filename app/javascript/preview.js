document.addEventListener('DOMContentLoaded', function() {
  const ImagePreview = document.getElementById('image-preview');
  document.getElementById('article-image').addEventListener('change', function(e){
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
  });
});