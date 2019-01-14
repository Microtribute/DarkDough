// JavaScript Document

function fn_init_waiter(){
  jQuery('.loading').remove();
  jQuery('<div class="loading"/>').appendTo('body').show();

  jQuery('.overlay').remove();
  jQuery('<div class="overlay"/>')
    .css({
      height:jQuery('body').height()
    })
    .appendTo('body')
    .show();
	jQuery('.loading').click(function(){
		fn_clear_waiter();
	});
}

function fn_clear_waiter(){
  jQuery('.loading').remove();
  jQuery('.overlay').remove();
}


function fn_init_waiter_mini(obj){
	var _left = $(obj).offset().left;
	var _top = $(obj).offset().top;
	
  jQuery('.loading_mini').remove();
  jQuery('<div class="loading_mini"/>').appendTo('body').show();

  jQuery('.overlay_mini').remove();
  jQuery('<div class="overlay_mini"/>')
    .css({
      height:jQuery('body').height()
    })
    .appendTo('body')
    .show();
		
	var __left = 5;
	var __top = 3;
	jQuery('.loading_mini')
		.css({'left': _left+__left,'top': _top+__top})
		.click(function(){
			fn_clear_waiter_mini();
		});
}

function fn_clear_waiter_mini(){
  jQuery('.loading_mini').remove();
  jQuery('.overlay_mini').remove();
}

