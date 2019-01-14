(function(){
  $.fn.progressBar = function() {
    var init = function () {
      var items = _($('.item', $(this)));

      items.each(function(elem){
        var progressBar = $('.progress', elem),
            amount = Math.abs(parseFloat($('.end', elem).text())),
            spended = Math.abs(parseFloat($('.start', elem).text())),
            itemWidth = progressBar.width(),
            progressWidth;

        if (amount < spended) {
          progressWidth = 100;
          progressBar.prepend("<div style='width:100%;' class='charged'>&nbsp;</div>");
        } else if (spended == 0) {
          progressWidth = 0;
          progressBar.prepend("<div class='active_bar' style='width:" + progressWidth + "px;'>&nbsp;</div>");
        } else {
          progressWidth = itemWidth *(spended / amount);
          progressBar.prepend("<div class='active_bar' style='width:" + progressWidth + "px;'>&nbsp;</div>");
        };
      })
    }

    return init.call(this);
  };
})(jQuery)