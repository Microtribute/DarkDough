// JavaScript Document
var g_init_interval = 0;
function fn_init_janrain(){
	if($('#janrainView').size()==0)return;
	$('#janrainView').next().css({'width':''}).width(320);
	$('.janrainContent').css({'width':''}).width(320);
	$('.providers li').css({'width':''}).width(150);
	$('#janrainProviderPages').prev().css({'width':''}).width(310);
	$('#janrainProviderPages').next().css({'width':''}).width(310);
	$('#janrainProviderPages').css({'left':'9px'});
	clearInterval(g_init_interval);
}


function isValidPhone(phonenumber){
	var regexObj = regexObj=/^[1-9]{1}[0-9]{9}$/;
	if (regexObj.test(phonenumber)) {
			return true;
	} else {
			return false;
	}
}

$(function(){
	$('.invite-form').submit(function(){
		$('#user_phone_number').val(parseInt($('.country-code input').val())+"-"+$('#user_phone_number').val());
		$('input[type=submit]',this).attr('disabled',true).css({'opacity':'0.6'})
		return true;
	});
	
	var s = $('#user_phone_number').val();
	if(typeof(s)!="undefined" && s!=""){
		var r = s.split(/\-/gi);
		$('.country-code input').val("+"+r[0]);
		$('#user_phone_number').val(r[1]);
	}
	
	$('#recaptcha_image').width(200);
	$('#recaptcha_area').attr('id','recaptcha_area1');
	$('#recaptcha_table').attr('id','');
	$('.recaptcha_r2_c1').width(13);
	$('.recaptchatable .recaptcha_r1_c1').height(7);
	$('.recaptchatable #recaptcha_response_field').attr('id','recaptcha_response_field-custom');
	
	$('#show_form_button').on('click', function(){
		$('.pre-form').fadeOut();
		$('.landing-form').fadeIn().get(0).scrollIntoView();
		fn_init_janrain();
	});
});

	var protocol = location.protocol;
	var host = location.host;
(function() {
		setInterval(function(){
			var country_code = $('.social-form .country-code input').val();
			var phone_number = $('.social-form .number input').val();
			if(!isValidPhone(phone_number)){
				$('.social-form .social-buttons .social-overlay').show();
				return;
			}else{
				$('.social-form .social-buttons .social-overlay').hide();
			}
			
			var ph = country_code.replace(/[^0-9]/gi,'')+"-"+phone_number;
			phone_number = encodeURIComponent(ph);
			janrain.settings.tokenUrl = protocol+"\/\/"+host+"/socialsignin?phone_number="+phone_number;
		},500);
    if (typeof window.janrain !== 'object') window.janrain = {};
    if (typeof window.janrain.settings !== 'object') window.janrain.settings = {};
		janrain.settings.tokenUrl = protocol+"\/\/"+host+"/socialsignin?phone_number=";
    
    

    function isReady() { janrain.ready = true; };
    if (document.addEventListener) {
      document.addEventListener("DOMContentLoaded", isReady, false);
    } else {
      window.attachEvent('onload', isReady);
    }

    var e = document.createElement('script');
    e.type = 'text/javascript';
    e.id = 'janrainAuthWidget';

    if (document.location.protocol === 'https:') {
      e.src = 'https://rpxnow.com/js/lib/mybudget247/engage.js';
    } else {
      e.src = 'http://widget-cdn.rpxnow.com/js/lib/mybudget247/engage.js';
    }

    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(e, s);
		
		g_init_interval = setInterval(fn_init_janrain,500);
})();




