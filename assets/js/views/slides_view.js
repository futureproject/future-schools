tfp.SlidesView = Backbone.View.extend({
  initialize: function(args) {
    this.listenTo(Backbone, 'slides:goTo', this.goTo);
  },
  events: {
    'click a': 'anchorHandler'
  },
  goTo: function(slide){
    slide = slide.length ? slide.get(0) : slide;
    $('html, body').animate({
      'scrollTop': "" + $(slide).offset().top + "px"
    });
  },
  anchorHandler: function(event) {
    var t = event.currentTarget;
    if (!!t.hash) {
      event.preventDefault()
      var elem = document.querySelector(t.hash)
      Backbone.trigger('slides:goTo', elem);
    }
    return true;
  }
})
