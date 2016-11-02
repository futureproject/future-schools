tfp.GalleryView = Backbone.View.extend({
  initialize: function(){
    if (window.matchMedia("(orientation: landscape), (min-width: 768px)").matches) {
      this.activate()
    }
  },
  events: {
    'click figure': 'onclick'
  },
  activate: function(){
    var self = this;
    this.$slides = this.$el.find('figure');
    if (this.$slides.length < 2) {
      this.$el.off();
      return null;
    }
    this.interval = 3000;
    this.$el.addClass('gallery-active');
    this.index = 0;
    this.next();
    this.timer = window.setInterval(function(){
      self.next()
    }, this.interval)
  },
  next: function(){
    this.$activeSlide().addClass('active').siblings().removeClass('active');
    this.index ++;
  },
  $activeSlide: function(){
    return $(this.$slides.get(this.index % this.$slides.length))
  },
  onclick: function(event) {
    window.clearInterval(this.timer);
    this.next();
  }
})
