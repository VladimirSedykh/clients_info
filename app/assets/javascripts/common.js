$(document).ready(function(){
  reminderTimer();
  $("#inputScheduledTime").datetimepicker(
    {dateFormat: "yy-mm-dd",
     altFieldTimeOnly: false
    }
  );
  var controller = $(".controller").val();
  $("." + controller).addClass("active");

  $(".phone").mask("(999) 999-9999");

  $(".client_edit_form").submit(function() {
    var name = $(this).find("#inputName");
    if(name.length != 0){
      if(name.val() == "" || name.val() == null){
        if (!$(".name-group").hasClass("error")){
          $(".name-group").addClass("error");
          $(".name-group").find(".error").remove();
          $(".name-group").find(".controls").append("<br /><span class='error'>Введите название.</span>");
        }
      return false;
      }
    }
  })

  var name_value = $(".client_edit_form").find("#inputName");
  if (name_value.val() != undefined && name_value.val() != ""){
    $("#create_client").modal();
  }

 $('a.close').click(function() {
    $(this).parent().fadeOut("fast");
  });

  $("#clean_search_form").live("click", function(){$("#search_form").find("input, select, textarea").not(".btn").val("")});

  $(".clickable-cell").click(function(){
    var link = $(this).find('.iframe-link');
    var attr = link.attr("attr");
    var bottomFrame = parent.frames[1];
    var frameset = top.window.document.getElementById('main-frameset');
    bottomFrame.location.href = ("/clients/" + attr + "?frame=true");
    if (frameset.rows == "100%,0%"){
      frameset.rows = "55%,45%";
    }
  })

  $("#close-frame").click(function(){
    top.window.document.getElementById('main-frameset').rows = '100%,0%';
  })

  $("#open-frame").click(function(){
    top.window.document.getElementById('main-frameset').rows = '60%,40%';
  })

  $.each($(".pagination a"), function(){
    $(this).addClass("ajax-link");
  })

  $("a").not(".dropdown-toggle, .iframe-link, #close-frame, .inframe, .ajax-link, .history-content a").click(function(){
    top.location = $(this).attr("href");
  })

  $(".toggle").livequery("dblclick", function(){
    var frameset = top.window.document.getElementById('main-frameset');
    var frameHeight = parent.frames[1].window.innerHeight;

    if (frameHeight > 60){
      frameset.rows = "100%,0%";
    } else {
      frameset.rows = "60%,40%";
    }
  })

  $("#toggle-search").click(function(){
     $("#search_client").toggle();
  });

  $("#toggle-create").click(function(){
     $(".client-new").toggle();
  });

  $(".reminder_checkbox").change(function(){
    var single = $(this).hasClass("single_record");
    if(single){
      url = "/all_reminders/" + $(this).val();
    }
    else{
      url = "reminders/" + $(this).val();
    }

    $.ajax({
      type: "PUT",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: url,
      data: { closed: $(this).attr('checked'), id: $(this).val() },
      success: function(data){
        if (url.match(/all_reminders/)){
          var past_count = $("#past-count").text();
          var today_count = $("#today-count").text();
          var tomorrow_count = $("#tomorrow-count").text();
          var future_count = $("#future-count").text();
          if(past_count != data.past_count){
            $("#past-count").text(data.past_count);
          }
          if(today_count != data.today_count){
            $("#today-count").text(data.today_count);
          }
          if(future_count != data.future_count){
            $("#future-count").text(data.future_count);
          }
          if(today_count != data.today_count){
            $("#tomorrow-count").text(data.tomorrow_count);
          }
        }
      },
      dataType: "json"
    });
  })

  function reminderTimer(){
    updateReminder();
    setInterval(updateReminder, 120000);
  };

  function updateReminder(){
    $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: "/all_reminders",
      success: function(data){
        var past_count = $("#past-count").text();
        var today_count = $("#today-count").text();
        if(past_count != data.past_count){
          $("#past-count").text(data.past_count);
        }
        if(today_count != data.today_count){
          $("#today-count").text(data.today_count);
        }
        if(data.messages != ""){
          var answer = confirm(data.messages);
          if(answer){
            $.ajax({
              type: "POST",
              url: "/all_reminders/update_viewed",
              data: {ids: data.past_ids},
              dataType: "json"
            })
          }
        }
      },
      dataType: "json"
    });
  }

  $(".label-important.reminder").click(function(){
    top.location = "/all_reminders?type=past_reminders"
  })

  $(".label-info.reminder").click(function(){
    top.location = "/all_reminders?type=today_reminders"
  })

  $(".label-warning.reminder").click(function(){
    top.location = "/all_reminders?type=tomorrow_reminders"
  })

  $(".label-success.reminder").click(function(){
    top.location = "/all_reminders?type=future_reminders"
  })
})
