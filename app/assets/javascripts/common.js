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
})
