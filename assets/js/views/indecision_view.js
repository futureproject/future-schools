// USAGE:
// var slide = document.querySelector('.slide')
//new tfp.IndecisionView({
  //el: slide,
  //wordChoices: slide.getAttribute('data-choices'),
  //targetEl: slide.querySelector('.indecision')
//})

tfp.IndecisionView = Backbone.View.extend({
  initialize: function(args) {
    var self = this;
    _.each(args, function(value, key, list) {
      self[key] = value;
    })
    this.interval = 100;
    this.currentWordIndex = 0;
    this.wordChoices = this.setWords(this.wordChoices);
    this.timer = this.startTimer();
    this.listenTo(Backbone, 'word:change', this.changeWord);
  },
  colors: ["#00c0ef", "#00d4bd", "#97e242", "#fab406", "#f63868", "#d43da3", "#3c82f7"],
  startTimer: function(){
    return window.setInterval(function(){
      Backbone.trigger('word:change');
    }, this.interval);
  },
  setWords: function(words) {
    var wordBank = words.split(",");
    var firstWord = wordBank.shift();
    wordBank.push(firstWord);
    return wordBank;
  },
  changeWord: function(){
    var self = this;
    var newIndex = this.currentWordIndex % this.wordChoices.length;
    var newColor = this.colors[this.currentWordIndex % this.colors.length];
    this.targetEl.innerHTML = "<span style='background-color: " + newColor + ";'>" + this.wordChoices[newIndex] + "</span>";
    if (newIndex == 0 && this.currentWordIndex > 0 ){
      var last = this.wordChoices.shift();
      this.wordChoices.push(last);
      window.clearInterval(this.timer);
      window.setTimeout(function(){
        self.timer = self.startTimer();
      }, 2000);
    }
    this.currentWordIndex += 1;
  }
})
