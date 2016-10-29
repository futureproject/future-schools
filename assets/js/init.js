$(function(){
  // activate signup buttons
  // activate BRAND INDECISION MATRIX
  _.each(document.querySelectorAll('.title-slide article'), function(slide){
    new tfp.IndecisionView({
      el: slide,
      wordChoices: slide.getAttribute('data-choices'),
      interval: 3000,
      targetEl: slide.querySelector('.indecision')
    })
  })
  // activate slideshows
})
