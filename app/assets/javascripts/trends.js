$(function(){
  var months = { 0: 'Jan', 1: 'Feb', 2: 'Mar', 3: 'Apr', 4: 'May', 5: 'Jun',
                 6: 'Jul', 7: 'Aug', 8: 'Sep', 9: 'Oct', 10: 'Nov', 11: 'Dec' },
      full_months = { 'Jan': 'January', 'Feb': 'February', 'Mar': 'March', 'Apr': 'April', 'May': 'May', 'Jun': 'Jun',
                      'Jul': 'July', 'Aug': 'August', 'Sep': 'September', 'Oct': 'October', 'Nov': 'November', 'Dec': 'December'},

      current_date = new Date(),
      curr_date = current_date.getDate(),
      curr_month = current_date.getMonth() + 1,
      next_month = curr_month + 1,
      curr_year = current_date.getFullYear();

  $('#trends_search').submit(function(){
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });

  subcategoryFilterLink = function() {
    var links = $('#sub_filter li');

    links.on("click", function(event) {
      var partial = $('#' + event.target.id + "_partial"),
          partials = $('div[id$=partial]'),
          categoryActiveLinkId = $('#main_filter li.active a').attr('id'),
          subPartial = $("." + categoryActiveLinkId + "_container", partial);
      partials.removeClass('active');
      partial.addClass('active');
      subPartial.addClass("active");

      $(this).siblings().removeClass('active');
      $(this).addClass('active');
      return false;
    });
  },

  toggleCategories = function() {
    var menuLinks = $('#main_filter a');

    menuLinks.on('click',(function(event) {
      var containers = $('.bubble-info');
      var resContainer = $("." + event.target.id + "_container"),
          categoryName = $(this).text();
      containers.removeClass('active');
      resContainer.addClass('active');
      $('#filter_category').text(categoryName);
      $(this).parent().siblings().removeClass('active');
      $(this).parent().addClass('active');
      if ($(this).hasClass('net_income')) {
        $('#by_category').hide('hidden');
        $('#by_merchant').hide('hidden');
        $('#over_time').click();
      }
      else {
        $('#by_category').show('hidden');
        $('#by_merchant').show('hidden');
      }
      return false;
    }))
  },

  // Creating the Timeline what finished by the current month
  createTimeline = function() {
    var timelineContainer = $('#timeline'),
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
    var cont = $('#timeline div');
    for (var i = 0; i < 12; i++){
      timelindeHashOfMonths[i] = $('#timeline div')[i].className.split(/\s+/)[1];
    };
  };

  $('#timeline').slider({
    min: 0,
    max: 12,
    values: [11,12],
    range: true,
    animate: true,
    create: function(event, ui) {
      createTimeline();
      $('.tl-months').text(full_months[timelindeHashOfMonths[11]]  + " - " + full_months[timelindeHashOfMonths[11]]);
      $('#trends_start').val(curr_year + "-" + curr_month + "-01");
      $('#trends_end').val(curr_year + "-" + next_month + "-01");
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
        startField = $('#trends_start'),
        endField = $('#trends_end');
    startField.val(rangeStart);
    endField.val(rangeEnd);
    $('#trends_search').submit();
  },

  highlightPeriod = function(ui) {
    var elems = $('#timeline div'),
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
    $('.tl-months').text(full_months[startMonthText] + ' - ' + full_months[endMonthText]);
  },

  timelinePeriodLinks = function() {
    // links
    var oneMonth = $('#timeline_one_month'),
        lastMonth = $('#timeline_last_month'),
        year = $('#timeline_year'),
        all = $('#timeline_all');

    oneMonth.click(function(){
      $('#timeline div').removeClass('selected');
      $('#timeline').slider("option", "values", [11,12]);
      $('#timeline div.timeline-month').last().addClass('selected');
      return false;
    });

    lastMonth.click(function(){
      $('#timeline div').removeClass('selected');
      $('#timeline').slider("option", "values", [10,11]);
      $('#timeline div.timeline-month:nth-child(11)').addClass('selected');
      return false;
    });

    year.click(function() {
      var today = new Date(),
          curr_year = today.getFullYear(),
          index = $('#timeline div.Dec').index() + 1;
      $('#timeline div').removeClass('selected');
      $('#timeline').slider("option", "values", [index,12]);
      $('div[id^=' + curr_year + ']').addClass('selected');
      return false;
    });

    all.click(function() {
      $('#timeline').slider("option", "values", [0,12]);
      $('#timeline div').addClass('selected');
      return false;
    });
  };

  subcategoryFilterLink();
  toggleCategories();
  timelinePeriodLinks();
});