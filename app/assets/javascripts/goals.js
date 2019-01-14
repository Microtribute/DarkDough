$(function() {
  var recalculateBalance = function() {
    var balance_fields = $('.available_accounts').find('em'),
        checkedCheckboxes = $('.available_accounts').find('input:checked'),
        amount = 0;
    checkedCheckboxes.each(function() {
      amount += parseFloat($(this).parent().find('em').text());
    });
    $('#goal_current_balance').text(amount);
  },

  goalBalance = function() {
    var balance_checkboxes = _([$('.available_accounts').find('input[type=checkbox]')]);

  recalculateBalance();
  balance_checkboxes.each(function(elem) {
      elem.bind('change', function() {recalculateBalance()})
    });
  },

  monthsBeforeEvent = function() {
    var plannedYear = parseInt($('#goal_planned_date_1i').val()),
        plannedMonth = parseInt($('#goal_planned_date_2i').val()),
        d1 = new Date(),
        d2 = new Date(plannedYear, plannedMonth),
        monthsDiff;

    monthsDiff = (d2.getFullYear() - d1.getFullYear()) * 12;
    monthsDiff -= d1.getMonth() + 1;
    monthsDiff += d2.getMonth();
    return monthsDiff;
  },

  calculateContribution = function() {
    var amount = parseFloat($('#goal_amount').val() || $('#spending_goal_amount').val()),
        balance = parseFloat($('#goal_current_balance').text()),
        contribution = $('#goal_contribution').val();

    var monthlyContribution = Math.round((amount - balance) / monthsBeforeEvent());
    $('#goal_contribution').val(monthlyContribution);
  },

  presentContributionToUser = function() {
    var fields = _([$('#goal_amount'), $('#goal_current_balance'), $('#goal_planned_date_1i'), $('#goal_planned_date_2i')]);
    fields.each(function(elem) {
      elem.bind('change', function() {calculateContribution()})
    });
  },

  // calculation Amount for 'Save for an emergency' form
  // amountCalculation = function() {
  //   var spending = $('#emergency_spending'),
  //       spendingMonths = $('#date_spending');

  //   selectedMonth = spendingMonths.find("option:selected").val();
  //   spend = spending.val() * selectedMonth;
  //   $('#spending_goal_amount').val(spend);
  //   calculateContribution();
  // },

  // amountPresentation = function() {
  //   var feildsBind = _([$('#emergency_spending'), $('#date_spending')]);

  //   amountCalculation();
  //   feildsBind.each(function(elem) {
  //     elem.bind('change', function() {amountCalculation()})
  //   });
  // },

  // finish goal
  finishGoal = function() {
    var finishGoallinks = $('.finish_goal_td .finish_goal');

    finishGoallinks.click(function(){
      var form = $(this).parent(),
          goalCheckbox = form.find('input[type=checkbox]');

      if (!goalCheckbox.is(':checked')) {
        goalCheckbox.click();
      }
      form.submit(function(){
        $.get(this.action, $(this).serialize(), null, "script");
      });

      form.find('input[type=submit]').click();
      return false;
    });
  };

  presentContributionToUser();
  goalBalance();
  // amountPresentation();
  finishGoal();
});
