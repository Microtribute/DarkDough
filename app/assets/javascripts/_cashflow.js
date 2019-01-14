// JavaScript Document

$(function(){
	$('body').click(function(){
		setTimeout(function(){
			$('.error').remove();
		},1000);
	});
	$('button').click(function(){
		$(this)
			.addClass('selected')
			.siblings().removeClass('selected');
		$(this).siblings(".answer").val($(this).val());
	});

	$('form#new_test').submit(function(){
		if(!g_submit_flag)return false;
		g_submit_flag = false;
		var passed = true;
		$('.error', this).remove();
		$("input.answer.required", this).each(function(){
			var v = $.trim($(this).val()); $(this).val(v);
			if(v==""){
				passed = false;
				$(this).after("<div class='error empty'/>")
			}
		});
		$("input.answer[value!='']", this).each(function(){
			var v = $(this).val();
			if($(this).attr('type')!='hidden' && /[^0-9]/.test(v)){
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
					window.open(g_testresult_path, "_self");
				}
			});
		}else{
			$('body').animate({'scrollTop':$('.error:first').offset().top-200});
		}
		return false;
	});
	
	var g_submit_flag = false;
	$('.proceed-btn').on('click', function(){
		g_submit_flag = true;
		$('form#new_test').submit();
	});
	
	
	
	
	$('.slider-bar').each(function(){
		$(this).slider({
			value: parseInt($(this).attr('default_value'))+1,
			min: 1,
			max: 100,
			step: 1,
			slide: function( event, ui ) {
					var id = $(event.target).attr('idd');
					$('#'+id).val(ui.value);
			}
		});
	});
	
	
	$('.slider-bar').mousemove(function(){
		slider_flag = true;
	});
	
	$('.slider-bar a').removeAttr('href');
	
	setInterval(function(){
		if(!slider_flag)return;
		slider_flag = false;
		$('.slider-bar a.ui-slider-handle').each(function(){
			var obj = $(this).parent();
			var val = parseInt($(this).css('left'));
			$('#'+obj.attr('idd')).val(val);
		});
	},100);
});

var slider_flag = true;

