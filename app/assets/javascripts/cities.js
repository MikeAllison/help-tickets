$(function () {
  // Set first input focus on add city modal
  $('#addCityModal').on('shown.bs.modal', function () {
    $('#city_name').focus();
  });

  // Remove any validation errors when modal is dismissed
  // and clear form fields
  $('#addCityModal').on('hidden.bs.modal', function () {
    $('.validation-errors').closest('.row').remove();
    $('#city_name').val(null);
    $('#city_state_id').val(null);
  });
});
