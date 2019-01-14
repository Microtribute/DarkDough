$(function(){
  var customAnswersCount = function() {
    var container = $(".result_fields"),
        inputs = container.find("input"),
        resultInput = container.siblings(".custom_result");

    inputs.change(function(){
      var counter = 0;
      for (i=0;i<=4;i++) {
        if (inputs[i].value) {
          counter = counter + 1;
        }
      }
      resultInput.val(counter);
    })
  };

  var customAnswersCountStart = function() {
    var container = $(".result_fields"),
        inputs = container.find("input"),
        resultInput = container.siblings(".custom_result");

    var counter = 0;
    for (i=0;i<=4;i++) {
      if (inputs[i] && inputs[i].value) {
        counter = counter + 1;
      }
    }
    resultInput.val(counter);
  }

  customAnswersCountStart();
  customAnswersCount();
});