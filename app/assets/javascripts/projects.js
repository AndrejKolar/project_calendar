$(document).ready(function() {

  if($('#finished_checkbox').is(':checked')) {
    $('#finished_group').show();
  } else {
    $('#finished_group').hide();
  }

  $('#finished_checkbox').change(function() {
      $('#finished_group').toggle(this.checked);
  });
 });


