$(function(){
  tfp.slideController = new tfp.SlidesView({
    el: document.querySelector('main')
  });
  // activate signup buttons
  // activate BRAND INDECISION MATRIX
  _.each(document.querySelectorAll('.title-slide article'), function(slide){
    new tfp.IndecisionView({
      el: slide,
      wordChoices: slide.getAttribute('data-choices'),
      targetEl: slide.querySelector('.indecision span'),
      events: {
        'click header': 'dismiss',
        'mousedown .indecision-choice': 'dismiss',
      }
    })
  })
  // activate slideshows
})
