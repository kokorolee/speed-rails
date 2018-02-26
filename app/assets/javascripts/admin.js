//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require cocoon
//= require chosen-jquery

//= require_tree .
$(document).ready(function(){
  $('.choz').chosen();

  // $('.form_datetime').datetimepicker({
  //   autoclose: true,
  //   todayBtn: true,
  //   pickerPosition: "bottom-left",
  //   format: 'mm-dd-yyyy hh:ii'
  // });

  $('body').on('hidden.bs.modal', '.modal', function () {
    $(this).removeData('bs.modal');
  });
});

