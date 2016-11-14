tfp.SignupFormView = Backbone.View.extend({
  initialize: function(){
    this.loadContent();
    this.$el.addClass('signup-form-slide');
  },
  events: {
    'submit': 'onsubmit',
  },
  loadContent: function(){
    var self = this;
    $.get("/forms/signup", function(response) {
      self.$el.html(response);
    })
  },
  onsubmit: function(event) {
    var self = this;
    this.$form = this.$form || this.$el.find('form');
    event.preventDefault();
    var data = this.getFormData();
    if (this.validates(data)) {
      /// submit the form
      $.ajax({
        method: this.$form.attr('method'),
        url: this.$form.attr('action'),
        data: { record: this.getFormData() },
        success: function(response) {
          self.$el.html("<article><h1>Thank you!</h1><p>Our team will reach out shortly.</p>");
        },
        error: function(response) {
          alert("Apologies! The system didn't save your form. Please try again.");
        }
      })
    }
    else {
      alert("Name and email are required.");
    }
  },
  getFormData: function(){
    var field, l, s = [];
    var form = this.form || this.el.querySelector('form');
    var len = form.elements.length;
    for (i=0; i<len; i++) {
    field = form.elements[i];
    if (field.name && !field.disabled && field.type != 'file' && field.type != 'reset' && field.type != 'submit' && field.type != 'button') {
    if (field.type == 'select-multiple') {
      l = form.elements[i].options.length; 
      for (j=0; j<l; j++) {
          if(field.options[j].selected)
            s[s.length] = { name: field.name, value: field.options[j].value };
          }
        } else if ((field.type != 'checkbox' && field.type != 'radio') || field.checked) {
          s[s.length] = { name: field.name, value: field.value };
        }
      }
    }
    var obj = {};
    _.map(s, function(elem) {
      var key = _.last(elem['name'].match(/\[(.*)\]/))
      obj[key] = elem['value']
    })
    return obj;
  },
  validates: function(data) {
    var valid = data["Name"] && data["Email"];
    return valid;
  }
})
