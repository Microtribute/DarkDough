(function($){
  $.fn.customForm = function() {
    var init = function() {
      var container = $('.tabbed'),
          links = $('a.edit', container),
          checkboxes = $('input[type=checkbox]', container),
          selects = $('select', container),
          cancelLinks = $('a.cancel', container),
          checkboxTemplate = _.template("<div class='custom_checkbox'>&nbsp;</div>"),
          forms = $('form', container);

      forms.each(function() {
        $(this).addClass('custom-form')
      });

      selects.each(function() {
        $(this).chosen();
      });

      links.click(function() {
        var linkContainer = $(this).parents('.edited-item');

        $(this).hide();
        if (!linkContainer.next().hasClass('edited-item')) {
          linkContainer.addClass('hidden');
          linkContainer.next().toggleClass('hidden').addClass('active');
        } else {
          linkContainer.toggleClass('active');
        }
        return false;
      });

      checkboxes.each(function() {
        $(this).hide();
        $(this).parent().prepend(checkboxTemplate);
        $(this).parents().find('form').first().addClass()
      });

      var customCheckboxes = $('.custom_checkbox');
      customCheckboxes.each(function() {
        var checkbox = $(this).siblings('input[type=checkbox]');
        if (checkbox.is(':checked')) {
          $(this).toggleClass('active_checkbox')
        }
      });

      customCheckboxes.click(function() {
        var checkbox = $(this).siblings('input[type=checkbox]'),
            form = $(this).parents('form').first();

        checkbox.click();
        $(this).toggleClass('active_checkbox');
        form.submit();
      });

      cancelLinks.click(function() {
        var linkClass = $(this).attr('class').split(/\s+/)[0],
            container = $(this).parents().find('.'+ linkClass),
            editLink = $('a.edit', container);

        editLink.show();
        if (container.next().hasClass('edited-item')) {
          container.toggleClass('active');
        } else {
          container.removeClass('hidden');
          container.next().addClass('hidden').removeClass('active');
        }
        return false;
      });

      forms.each(function() {
        var options ={
          dataType: 'script'
        }
        $(this).ajaxForm(options);
      });
    };

    return init.call(this);
  };
})(jQuery)