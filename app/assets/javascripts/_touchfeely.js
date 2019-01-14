// JavaScript Document

var r_proceed_forms = [];

$(function(){
	$('#btn-proceed').click(function(){
		r_proceed_forms = [];
		if(fn_validate_radio() && fn_validate_table()){
			$('form[submitted=no]').each(function(){
				r_proceed_forms.push($(this));
			});
			fn_submit_recursive();
		}
		
	});
});

function fn_submit_recursive(){
	if(r_proceed_forms.length==0){
		if(LOADING_MODE)fn_clear_waiter();
		window.open(g_hardfacts_path,"_self");
		return;
	}
	var form = r_proceed_forms.pop();
	var url = form.attr('action');
	var _form = form;
	if(LOADING_MODE)fn_init_waiter();
	$.ajax({
		type: "POST",
		url: url,
		data: form.serialize(),
		success: function(data)
		{
			_form.attr('submitted','yes');
			fn_submit_recursive();
		}
	});
}