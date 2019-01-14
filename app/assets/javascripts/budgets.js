$(function() {
  // init datepicker for serching budgets date range
  $('#budgets_search').submit(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });

  var budgetOptions = function() {
    var inputs = $('.field.radios input'),
        period = $('#budget_period'),
        fakePeriod = $('#period'),
        year = $('#budget_start_1i'),
        month = $('#budget_start_2i'),
        startContainer = $('form .start'),
        periodContainer = $('.period')

        currentMonthNumber = (new Date().getMonth() + 1);

    inputs.click(function() {
      if (this.id == 'period_few_month') {
        if ($('#budget_year').length > 0) {
          $('option[value= ' + $('#budget_year').text() + ']', year).attr('selected', 'selected');
          $('option[value=' + parseInt($('#budget_month').text() + ']'), month).attr('selected', 'selected');
        } else {
          $('option:eq(' + currentMonthNumber + ')', month).attr('selected', 'selected');
          $('option:first', year).attr('selected', 'selected');
        }
        period.val($('option:selected', fakePeriod).val());
        startContainer.show();
        periodContainer.show();
      } else if (this.id == 'period_monthly') {
        $('option:first', month).attr('selected', 'selected');
        $('option:first', year).attr('selected', 'selected');
        period.val('1');
        startContainer.hide();
        periodContainer.hide();
      } else {
        $('option:first', month).attr('selected', 'selected');
        $('option:first', year).attr('selected', 'selected');
        period.val('0');
        startContainer.hide();
        periodContainer.hide();
      }
    });

    fakePeriod.change(function() { period.val($('option:selected', fakePeriod).val()); });

    if (period.val() == 0) {
      $('#period_once').click();
      period.val(0);
    } else if (period.val() == 1) {
      $('#period_monthly').click();
      period.val(1);
    } else {
      $('#period_few_month').click()
    }
  };


  // timeline
  var months = { 0: 'Jan', 1: 'Feb', 2: 'Mar', 3: 'Apr', 4: 'May', 5: 'Jun',
                 6: 'Jul', 7: 'Aug', 8: 'Sep', 9: 'Oct', 10: 'Nov', 11: 'Dec' },
      full_months = { 'Jan': 'January', 'Feb': 'February', 'Mar': 'March', 'Apr': 'April', 'May': 'May', 'Jun': 'Jun',
                      'Jul': 'July', 'Aug': 'August', 'Sep': 'September', 'Oct': 'October', 'Nov': 'November', 'Dec': 'December'},

      current_date = new Date(),
      curr_date = current_date.getDate(),
      curr_month = current_date.getMonth() + 1,
      next_month = curr_month + 1,
      curr_year = current_date.getFullYear();

  // Creating the Timeline what finished by the current month
  createTimeline = function() {
    var timelineContainer = $('#budgets_timeline'),
        template = _.template("<div class='timeline-month <%= month_class %>' id='<%= month_id %>'><%= month %></div>"),
        today = new Date(),
        aMonth = today.getMonth();
        // Global variables
        timelineHashForStart = {};
        timelineHashForEnd = {};
    for (var i=11; i>=0; i--) {
      var new_month_start = today.getMonth() + 1,
          new_month_end = today.getMonth() + 2,
          start_year_mark;

      timelineContainer.prepend(template({
        month_class: months[aMonth],
        month: months[aMonth],
        month_id: (today.getFullYear() + '-' + new_month_start + '-01')
      }));
      timelineHashForStart[i] = (today.getFullYear() + '-' + new_month_start + '-01');
      if (new_month_end == 13) {
        timelineHashForEnd[i] = ((today.getFullYear() + 1) + '-01' + '-01');
      } else {
        timelineHashForEnd[i] = (today.getFullYear() + '-' + new_month_end + '-01');
      }
      aMonth--;
      today.setMonth(today.getMonth() - 1);
      if (aMonth < 0) { aMonth = 11; }
    }

    timelindeHashOfMonths = {};
    var cont = $('#budgets_timeline div');
    for (var i = 0; i < 12; i++){
      timelindeHashOfMonths[i] = $('#budgets_timeline div')[i].className.split(/\s+/)[1];
    };
  };

  $('#budgets_timeline').slider({
    min: 0,
    max: 12,
    values: [11,12],
    range: true,
    animate: true,
    create: function(event, ui) {
      createTimeline();
      $('.budgets-months').text(full_months[timelindeHashOfMonths[11]]  + " - " + full_months[timelindeHashOfMonths[11]]);
      $('#budgets_start').val(curr_year + "-" + curr_month + "-01");
      $('#budgets_end').val(curr_year + "-" + next_month + "-01");
      $('.timeline-month:last').addClass('selected');
    },
    slide: function(event, ui){
      highlightPeriod(ui);
      showFullMonthsRange(ui);
    },
    change: function(event, ui) {
      setRange(ui);
    }
  });

  var setRange = function(ui) {
    var rangeStart = timelineHashForStart[ui.values[0]],
        rangeEnd = timelineHashForEnd[ui.values[1] - 1],
        startField = $('#budgets_start'),
        endField = $('#budgets_end');
    startField.val(rangeStart);
    endField.val(rangeEnd);
    $('#budgets_search').submit();
  },

  highlightPeriod = function(ui) {
    var elems = $('#budgets_timeline div'),
        startElem = timelineHashForStart[ui.values[0]],
        endElem =  timelineHashForStart[ui.values[1] - 1],
        today = new Date(),
        new_month_end = today.getMonth() + 1;

    elems.removeClass('selected');
    $('#' + startElem).addClass('selected');
    $('#' + endElem).addClass('selected');
    if (startElem !== endElem) {
      $('#' + startElem).nextUntil('#' + endElem).addClass('selected');
    }
  },

  showFullMonthsRange = function(ui) {
    var startMonthText = timelindeHashOfMonths[ui.values[0]],
        endMonthText = timelindeHashOfMonths[ui.values[1] - 1];
    $('.budgets-months').text(full_months[startMonthText] + ' - ' + full_months[endMonthText]);
  },

  timelinePeriodLinks = function() {
    // links
    var oneMonth = $('#timeline_one_month'),
        lastMonth = $('#timeline_last_month'),
        year = $('#timeline_year'),
        all = $('#timeline_all');

    oneMonth.click(function(){
      $('#budgets_timeline div').removeClass('selected');
      $('#budgets_timeline').slider("option", "values", [11,12]);
      $('#budgets_timeline div.timeline-month').last().addClass('selected');
      return false;
    });

    lastMonth.click(function(){
      $('#budgets_timeline div').removeClass('selected');
      $('#budgets_timeline').slider("option", "values", [10,11]);
      $('#budgets_timeline div.timeline-month:nth-child(11)').addClass('selected');
      return false;
    });

    year.click(function() {
      var today = new Date(),
          curr_year = today.getFullYear(),
          index = $('#budgets_timeline div.Dec').index() + 1;
      $('#budgets_timeline div').removeClass('selected');
      $('#budgets_timeline').slider("option", "values", [index,12]);
      $('div[id^=' + curr_year + ']').addClass('selected');
      return false;
    });

    all.click(function() {
      $('#budgets_timeline').slider("option", "values", [0,12]);
      $('#budgets_timeline div').addClass('selected');
      return false;
    });
  };

  $('.start #budget_start_1i').chosen();
  $('.start #budget_start_2i').chosen();
  $('.period #period').chosen();

  $('.radiogroup').customizeRadiobuttons();


  timelinePeriodLinks();

  budgetOptions();

  $('#result').progressBar();
});