// JavaScript Document
var LOADING_MODE = true;
$(function(){
	$('.table_type button').on('click', function(){
		if($(this).hasClass('selected'))return;
		var _this = this;
		$(_this)
			.addClass('selected')
			.siblings().removeClass('selected');
		
		var obj = $(this).siblings('span.label');
		obj.removeClass('warn');

		var form = $(_this).parents('form');
		var table = $(_this).parents('.table_type');
		fn_feed_form_for_table(_this);
		return;
		if(LOADING_MODE)fn_init_waiter_mini(_this);
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
	
	fn_feed_form_for_table($('.table_type button:first'));
	
});

function fn_feed_form_for_table(_this){
	var s = "";
	var table = $(_this).parents('.table_type');
	var form = $(_this).parents('form');
	$('.row', table).each(function(){
		var id1 = $(this).attr('id');
		var id2 = $('button.selected',this).attr('id');
		id2 = (id2==undefined)?"":id2;
		s += "\n" + id1 + "=>" + id2;
	});
	s = s.substr(1);
	$('#test_answer', form).val(s);
}


function fn_validate_table(){
	var b_break = false;
	var passed = true;
	$('.table_type .row').each(function(){
		if(b_break)return;
		if($('button.selected', this).size()==0){
			var obj = $('span.label',this);
			obj.addClass('warn');
			$('body').animate({'scrollTop':obj.offset().top-100});
			b_break = true;
			passed = false;
		}
	});
	return passed;
}

