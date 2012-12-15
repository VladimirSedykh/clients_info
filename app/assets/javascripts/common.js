$(document).ready(function(){
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

  $("#clean_search_form").live("click", function(){$("#search_form.modal-body").find("input, select, textarea").not(".btn").val("")});

  $(".iframe-link").click(function(){
    var attr = $(this).attr("attr");
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

  $("a").not(".dropdown-toggle, .iframe-link, #close-frame, .inframe, .ajax-link").click(function(){
    top.location = $(this).attr("href");
  })

  $(".toggle").livequery("dblclick", function(){
    var frameset = top.window.document.getElementById('main-frameset');
    var frameHeight = parent.frames[1].window.innerHeight


    console.log(frameset.rows);
    console.log(frameHeight);
    if (frameHeight > 60){
      console.log(1);
      frameset.rows = "100%,0%";
    } else {
      console.log(2);
      frameset.rows = "60%,40%";
    }
  })
})
