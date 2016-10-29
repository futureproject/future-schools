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
    this.interval = this.interval || 200;
    this.currentWordIndex = 0;
    this.wordChoices = this.setWords(this.wordChoices);
    this.timer = window.setInterval(function(){
      self.changeWord.call(self)
    }, this.interval);
  },
  setWords: function(words) {
    var wordBank = words.split(",");
    var firstWord = wordBank.shift();
    wordBank.push(firstWord);
    return wordBank;
  },
  changeWord: function(){
    //this.targetEl.innerHTML = this.wordChoces[newSlide];
    this.targetEl.innerHTML = "<span>" + this.wordChoices[this.currentWordIndex % this.wordChoices.length] + "</span>";
    this.currentWordIndex += 1;
  }
})
