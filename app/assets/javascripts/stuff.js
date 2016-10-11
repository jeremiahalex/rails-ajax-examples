/* globals $ */
// ::Rails AJAX requests we can intercept
// ajax:before      // fires before the request starts, provided a URL was provided in href or action
// ajax:loading     // fires after the AJAX request is created, but before it's sent
// ajax:beforeSend  // equivalent to ajax:loading in earlier versions
// ajax:error       // equivalent to ajax:failure in earlier versions
// ajax:success     // fires after a response is received, provided the response was a 200 or 300 HTTP status code
// ajax:failure     // fires after a response is received, if the response has a 400 or 500 HTTP status code
// ajax:complete    // fires after ajax:success or ajax:failure
// ajax:after       // fires after the request events are finished

$(document).on('turbolinks:load', function () {
  var stuffTemplate = $('#_stuff').html().trim()

  function loadAllStuff () {
    $.getJSON('/stuffs', function (data) {
      $('#list_stuffs').empty()
      data.forEach(function (elem) {
        var newStuff = $(stuffTemplate)
        newStuff.children('.stuff-name').text(elem.name)
        newStuff.children('.stuff-description').text(elem.description)
        newStuff.find('.delete-stuff').attr('href', '/stuffs/' + elem.id)
        // bind events for deleting
        newStuff.on('ajax:success', function () {
          Materialize.toast('Stuff Deleted!', 2000)
          loadAllStuff()
        })
        $('#list_stuffs').append(newStuff)
      })
      console.log('Reload was performed.')
    })
  }

  $('#add-stuff').on('ajax:success', function () {
    Materialize.toast('New Stuff Created!', 2000)
    loadAllStuff()
  })
  $('#add-stuff').on('ajax:beforeSend', function () {
    // clear the form
    $('#add-stuff')[0].reset();
  })

  // load all data after page first loads
  loadAllStuff()

  // Tell materialize that the fields have changed
  Materialize.updateTextFields();
})
