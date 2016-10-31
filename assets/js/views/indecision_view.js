// USAGE:
// var slide = document.querySelector('.slide')
//new tfp.IndecisionView({
  //el: slide,
  //targetEl: slide.querySelector('.indecision')
//})

tfp.IndecisionView = Backbone.View.extend({
  initialize: function(args) {
    var self = this;
    _.each(args, function(value, key, list) {
      self[key] = value;
    })
    this.interval = 2000;
    this.currentWordIndex = 0;
    this.wordChoices = this.targetEl.children;
    this.timer = this.startTimer();
    this.listenTo(Backbone, 'word:change', this.changeWord);
    Backbone.trigger('word:change');
  },
  colors: ["#00c0ef", "#00d4bd", "#97e242", "#fab406", "#f63868", "#d43da3", "#3c82f7"],
  startTimer: function(){
    return window.setInterval(function(){
      Backbone.trigger('word:change');
    }, this.interval);
  },
  changeWord: function(){
    var self = this;
    var newIndex = this.currentWordIndex % this.wordChoices.length;
    var newColor = this.colors[this.currentWordIndex % this.colors.length];
    $(this.wordChoices[newIndex]).addClass('is-active').attr('style', 'background-color: ' + newColor + ';').siblings().removeClass('is-active');
    this.currentWordIndex ++;
  },
  dismiss: _.debounce(function(event) {
    var $target = this.$el.closest('.slide').next();
    Backbone.trigger('slides:goTo', $target);
  }, 500, true)
})
