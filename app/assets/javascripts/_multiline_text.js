// JavaScript Document
var LOADING_MODE = true;
$(function(){
	$('.multiline_text_type .save').on('click', function(){
		$(this).toggleClass('selected');
		var form = $(this).parents('form');
		return;
		if(LOADING_MODE)fn_init_waiter_mini(this);
		var _this = this;
		var url = form.attr('action');
		var _form = form;

		fn_feed_form(this);
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
	
	$('.multiline_text_type input.added').live('keyup', fn_feed_form_keyup);

	$('.multiline_text_type .add').on('click', function(){
		var val = $('.multiline_text_type .row:last input[type=text]').val();
		if(val=="") return;
		var s_html = "<div class='row'><input class='added' value='"+val+"' type='text'/><span class='delete'/></div>";
		$('.multiline_text_type .row:last').before($(s_html));
		$('.multiline_text_type .row:last input[type=text]').val('');
		fn_feed_form(this);
	});

	$('.multiline_text_type .delete').live('click', function(){
		var o = $(this).parents('.row').siblings().first();
		$(this).parents('.row').remove();
		fn_feed_form($(o));
	});
	
	$('.multiline_text_type .add').each(function(){
		fn_feed_form(this);
	});


});


function fn_feed_form(_this){
	var form = $(_this).parents('form');
	var table = $(_this).parents('.multiline_text_type');
	var s = "";
	$('input.added', table).each(function(){
		var val = $(this).val();
		if(val!="")s += "\n"+val;
	});
	s = s.substr(1);
	$('#test_answer', form).val(s);
}


function fn_feed_form_keyup(){
	fn_feed_form(this);
}

