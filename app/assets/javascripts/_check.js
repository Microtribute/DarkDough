// JavaScript Document
var LOADING_MODE = true;
$(function(){
	$('.check_type button').on('click', function(){
		$(this).toggleClass('selected');
		var form = $(this).parents('form');
		var table = $(this).parents('.check_type');
		var s = "";
		$('button.selected', table).each(function(){
			s += ","+$(this).attr('id');
		});
		s = s.substr(1);
		$('#test_answer', form).val(s);
		return;
		if(LOADING_MODE)fn_init_waiter_mini(this);
		var _this = this;
		var url = form.attr('action');
		
		var _form = form;
		$.ajax({
			type: "POST",
			url: url,
			data: form.serialize(),
			success: function(data)
			{
				_form.attr('submitted','yes');
				if(LOADING_MODE)fn_clear_waiter_mini();
			}
		});
	});
});

