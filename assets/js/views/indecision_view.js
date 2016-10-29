tfp.IndecisionView = Backbone.View.extend({
  initialize: function(args) {
    var self = this;
    _.each(args, function(value, key, list) {
      self[key] = value;
    })
    self.currentWordIndex = 0;
    self.wordChoices = self.wordChoices.split(',');
    // set interval
    self.timer = window.setInterval(function(){
      self.changeWord.call(self)
    }, self.interval);
  },
  changeWord: function(){
    newSlide = this.currentWordIndex % this.wordChoices.length;
    console.log(this.wordChoices[newSlide]);
    this.currentWordIndex += 1;
  }
})
