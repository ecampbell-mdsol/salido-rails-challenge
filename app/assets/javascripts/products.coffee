$ ->
  $('#products').dataTable
    processing: true
    serverSide: true
    ajax: $('#products').data('source')
    pagingType: 'full_numbers'
