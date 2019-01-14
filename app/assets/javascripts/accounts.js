$(function(){
  $('.chosen').chosen();

  $('.add-account').click(function() {
    $('#new-account-dialog').toggleClass('active');
  });

  $('.dialog-cancel').click(function() {
    $('#new-account-dialog').toggleClass('active');
  });

  if ($('#banks-list').length > 0) {
    var availableBanks = $('#banks-list').html().split(',');
    $('#search-input').autocomplete({
      source: availableBanks,
      select: function(event, ui) {
        $('#banks-list-wrapper').addClass('active')
      }
    });
  };

  $('.clear-bank').click(function() {
    var input = $(this).parent().siblings('input');
    input.val('');
    $('#banks-list-wrapper').removeClass('active')
  });

  $('.bank-search form').submit(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });

  $('.new-account-form').submit(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });

  $('.search-link').click(function() {
    $(this).parents('form').submit();
  });

  var links = $('.popular-bank a');
  links.on('click', function() {
    $(this).next().submit();
  });
});
