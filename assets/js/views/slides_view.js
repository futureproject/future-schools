tfp.SlidesView = Backbone.View.extend({
  initialize: function(args) {
    this.listenTo(Backbone, 'slides:goTo', this.goTo);
    this.listenTo(Backbone, 'signup:clicked', this.signupHandler);
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
    // intercept same-page links and activate smooth-scrolling
    if (!!t.hash) {
      event.preventDefault()
      var elem = document.querySelector(t.hash)
      Backbone.trigger('slides:goTo', elem);
    }
    // open forms and embeds in a lightbox
    else if (t.href.match(/airtable|vimeo|youtube/i)) {
      event.preventDefault();
      $.featherlight({
        iframe: t.href
      })
    }
    if (t.href.match(/forms|signup/i)) {
      event.preventDefault();
      Backbone.trigger('signup:clicked');
    }
    return true;
  },
  signupHandler: function(event) {
    var form = new tfp.SignupFormView({
      el: document.querySelector("#signup")
    });
    $("#floating-signup-button").fadeOut(function(){
      $(this).remove();
    });
  }
})
