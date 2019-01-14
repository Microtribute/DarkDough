// JavaScript Document

$(function(){
	$('.confirmation form').submit(function(){
		return $('input[type=password]:eq(0)').val()==$('input[type=password]:eq(1)').val();
	});
	//$('#user_password').pstrength();
});

