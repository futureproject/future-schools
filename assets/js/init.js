$(function(){
  tfp.slideController = new tfp.SlidesView({
    el: document.querySelector('main')
  });
  // activate signup buttons
  // activate BRAND INDECISION MATRIX
  _.each(document.querySelectorAll('.title-slide article'), function(slide){
    new tfp.IndecisionView({
      el: slide,
      targetEl: slide.querySelector('.indecision'),
      events: {
        'click header': 'dismiss'
      }
    })
  })
  // activate slideshows
  _.each(document.querySelectorAll('.gallery-slide'), function(slide){
    new tfp.GalleryView({
      el: slide
    })
  })
})
