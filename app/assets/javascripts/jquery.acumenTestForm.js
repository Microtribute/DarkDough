(function($){
  $.fn.acumenTestForm = function() {
    var init = function() {
      var form = $(this),
          smilesContainer = $('.answer_smiles', form),
          fieldsContainer = $('.answer_fields', form),
          smiles = $('.smile', smilesContainer),
          smilesFields = $('.field', smilesContainer),
          fields = $('.field', fieldsContainer)
          checkboxes = $('.question_fields.checkboxes .checkbox'),
          inputCheckboxes = $('..input_fields .input.checkbox .answer');

      smiles.each(function() {
        var smileClass = $('input', $(this))[0].className,
            smileContainer = $(this).children('span');
        smileContainer.addClass(smileClass);
      });

      smiles.click(function() {
        var that = $(this),
            radio = that.children('input'),
            container = radio.parents('.question_fields');

        that.siblings().removeClass('checked');
        that.addClass('checked');
        radio.attr('checked', true);

        checkAnswerPresent(container);
      });

      smilesFields.click(function() {
        var that = $(this),
            radio = that.children('input'),
            container = radio.parents('.question_fields');

        that.siblings().removeClass('checked');
        that.addClass('checked');
        radio.attr('checked', true);

        checkAnswerPresent(container);
      });

      fields.click(function(){
        var that = $(this),
            radio = that.children('input'),
            container = radio.parents('.question_fields');

        that.siblings().removeClass('checked');
        that.addClass('checked');
        radio.attr('checked', true);

        checkAnswerPresent(container);
      })

      checkboxes.click(function() {
        var that = $(this),
            checkboxInput = $('input[type=checkbox]', that),
            container = that.parents('.question_fields');

        if (checkboxInput.is(':checked') == true) {
          checkboxInput.removeAttr('checked')
          that.removeClass('checked')

          checkAllCheckboxes(container);
        } else {
          checkboxInput.prop('checked', true)
          that.addClass('checked')

          checkAllCheckboxes(container);
        }
      });

      inputCheckboxes.click(function() {
        var that = $(this),
            checkboxInput = $('input[type=checkbox]', that),
            container = that.parents('.input_fields');

        if (checkboxInput.is(':checked') == true) {
          checkboxInput.removeAttr('checked')
          that.removeClass('checked')

          checkAllCheckboxes();
        } else {
          checkboxInput.prop('checked', true)
          that.addClass('checked')

          checkAllCheckboxes();
        }
      })

      var checkAllCheckboxes = function() {
        var checkbox = $('input[type=checkbox]:checked'),
            checkboxContainer = checkbox.parents('.input_fields');
        if (checkbox.length > 0) {
          checkboxContainer.addClass('done');
        } else {
          checkboxContainer.removeClass('done');
        }
      }

      var checkAllRadios = function() {
        var radio = $('input[type=radio]:checked'),
            radioContainer1 = radio.parents('.smile'),
            radioContainer2 = radio.parents('.field'),
            answerContainer = radio.parents('.question_fields');
        if (radio.length > 0) {
          radioContainer1.addClass('checked')
          radioContainer2.addClass('checked')
          answerContainer.addClass('done')
        } else {
          container.removeClass('checked');
        }
      }

      var checnCheckboxesOnEdit = function() {
        var checkbox = $('input[type=checkbox]:checked'),
            checkboxContainer = checkbox.parents('.checkbox');
        checkboxContainer.addClass('checked')
      }

      var checkAnswerPresent = function(container) {
        var radio = $('input[type=radio]:checked', container);
        if (radio.length > 0) {
          container.addClass('done');
        }
      };

      var numberToClass = function(number) {
        var result = '';
        if (number == 0) {
          result = 'first'
        } else if (number == 1) {
          result = 'second'
        } else if (number == 2) {
          result = 'third'
        }
        return result;
      }

      var classToNumber = function(elementClass) {
        var result = '';
        if (elementClass === 'first') {
          result = 1
        } else if (elementClass === 'second') {
          result = 2
        } else if (elementClass === 'third') {
          result = 3
        }
        return result;
      }

      var dragElements = function() {
        var draggableElements = $('[class^=drag_]'),
            draggableContainers = $('.drag_container'),
            dragInputs = $('.drag_input');

            draggableElements.draggable({
              snap: draggableContainers,
              snapMode: 'inner',
              zIndex: 100
            });

            draggableContainers.droppable({
              drop: function(event, ui) {
                var thisClass = $(this)[0].className.split(/\s+/)[1],
                    containerClass = parseInt(ui.draggable[0].className.split(/\s+/)[0].split('_')[1]);
                // console.log(ui.draggable);  // this element
                // console.log($(this));       // will be dropped to this element

                $(this).addClass('activated').removeClass('initial');
                ui.draggable.addClass('dropped')
                $('.drag_input.' + numberToClass(containerClass)).val(classToNumber(thisClass));

                $('.dropped i').live('click', function() {
                  $(this).parents('span').css('position', 'relative').css('left', 'auto').css('top', 'auto').removeClass('dropped');
                  $('.drag_input.' + numberToClass(containerClass)).val('');
                })
              }
            })
      }

      var returnDragged = function() {

        dragElements();
      }
      dragElements();
      // returnDragged();


      // var checkProgress = function(form){
      //   var testCheckboxes = $('input[type=checkbox]', form),
      //       testRadios = $('input[type=radio]', form),
      //       testFields = $('input[type=text]', form),
      //       dragFields = ;
      // }

      checkAllRadios();
      checnCheckboxesOnEdit();
      // checkAnswerPresent();
    };

    return init.call(this);
  };
})(jQuery)
