# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.subpopover').popover({'placement': 'bottom'})
  
  $('td.moreinfo').click ->
    $(this).closest('tr').attr("rel")
    $.get "/clients/modal_data", { 'client_query': $(this).closest('tr').attr("rel") },
      (data) ->
        if data.code == 0
          $('#client-data-modal').html(data['data'])
          $('#client-data-modal').modal("show")
        else
          alert(data.msg)

  $('td.showchecks').click ->
    $(this).closest('tr').attr("rel")
    $.get "/clients/history", { 'client_name': $(this).closest('tr').attr("rel") },
    (data) ->
      if data.code == 0
        $('#client_history-data-modal').html(data['data'])
        $(".bar").peity("bar", {
          width: 100
          height: 100
        });
        $('#client_history-data-modal').modal("show")

      else
        alert(data.msg)
  $('a.delete-client').click ->
    self = $(this)
    if (confirm('Are you sure?'))
      $.post "/clients/delete_client", { 'key': $(this).attr('key') },
        (data) ->
          if data
            $("#client_row_" + $(self).attr('key')).hide()
          else
            alert("Could not delete client")

  use_environments = $("#use_environments").attr("rel")
  if use_environments == "true"
    aocolumns = [null, null, null, null, null, null, {bSortable: false}, {bSortable: false}]
  else
    aocolumns = [null, null, null, null, null, {bSortable: false}, {bSortable: false}]

  ao_checks_columns = [null, null, null, null]

  dtable = $('#clients_table').dataTable
    bAutoWidth: false
    bSort: true
    aoColumns: aocolumns
    bPaginate: false

  checkstable = $('#clients_history_table').dataTable
    bAutoWidth: false
    bSort: true
    aoColumns: ao_checks_columns
    bPaginate: false


