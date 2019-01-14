// JavaScript Document

$(function(){
	$('form#new_test').submit(function(){
		var passed = true;
		$('.error').remove();
		$("input.answer.required", this).each(function(){
			var v = $.trim($(this).val()); $(this).val(v);
			if(v==""){
				passed = false;
				$(this).after("<div class='error empty'/>")
			}
		});
		$("input.answer[value!='']", this).each(function(){
			var v = $(this).val();
			if(/[^0-9]/.test(v)){
				passed = false;
				if($(this).siblings('.error').size()==0){
					$(this).after("<div class='error invalid'/>")
				}
			}
		});
		
		if(passed){
			var form = $('form#new_test');
			var url = form.attr('action');
			fn_init_waiter();
			$.ajax({
				type: "POST",
				url: url,
				data: form.serialize(),
				success: function(data)
				{
					fn_clear_waiter();
					window.open(g_cashflow_path, "_self");
				}
			});

		}else{
			$('body').animate({'scrollTop':$('.error:first').offset().top-200});
		}
		return false;
	});
	
	$('.proceed-btn').on('click', function(){
		$('form#new_test').submit();
	});
});

