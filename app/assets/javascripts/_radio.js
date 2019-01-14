// JavaScript Document
var LOADING_MODE = true;
$(function(){
	$('form').submit(function(){
		return false;
	});

	$('.radio_type button, .radio_with_multivalue_type button').on('click', function(){
		if($(this).hasClass('selected'))return;
		var obj = $(this).parents('div').siblings('span');
				obj.removeClass('warn');
		var form = $(this).parents('form');
		var answer = $(this).attr('id');
		$('#test_answer', form).val(answer);
		$(this)
			.addClass('selected')
			.siblings().removeClass('selected');
		return;


		//if(LOADING_MODE)fn_init_waiter_mini(this);
		var _this = this;
		var url = form.attr('action');
		var _form = form;
		$.ajax({
			type: "POST",
			url: url,
			data: form.serialize(),
			success: function(data)
			{
				$(_this)
					.addClass('selected')
					.siblings().removeClass('selected');
				_form.attr('submitted','yes');
				if(LOADING_MODE)fn_clear_waiter_mini();
			}
		});
	});
});


function fn_validate_radio(){
	var b_break = false;
	var passed = true;
	$('.radio_type, .radio_with_multivalue_type').each(function(){
		if(b_break)return;
		if($('button.selected', this).size()==0){
			var obj = $(this).siblings('span');
			obj.addClass('warn');
			$('body').animate({'scrollTop':obj.offset().top-100});
			b_break = true;
			passed = false;
		}
	});
	return passed;
}

