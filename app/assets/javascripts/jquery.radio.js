(function(){
  $.fn.customizeRadiobuttons = function() {
    var init = function() {
      var radiobuttons = $('input', $(this)),
          labels = $('label', $(this)),
          activeElementClass = $('input:checked', $(this)).val(),
          template = _.template("<div class='<%= labelTextClass %> new_radio'><%= text %><i></i><div>");

      radiobuttons.hide();
      labels.hide();

      radiobuttons.each(function() {
        var $this = $(this)
            labelText = $this.next().text(),
            labelTextClass = $this.val();
        $this.parent().append(template({
          text: labelText,
          labelTextClass: labelTextClass
        }))
      });

      $(".new_radio." + activeElementClass).addClass('active');


      var newElements = $('.new_radio', $(this));
      newElements.on('click', function() {
        var that = $(this),
            classForFind = that.attr('class').split(/\s+/)[0],
            radioButton = $("input[id*=" + classForFind + "]");
        radioButton.click();
        newElements.removeClass('active');
        that.addClass('active');
      })
    };

    return init.call(this);
  };
})(jQuery)