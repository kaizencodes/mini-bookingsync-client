App.cable.subscriptions.create {channel: "BookingsChannel"},
  received: (data) ->
    $("#price").html("Price: " + data)

  connected: ->
    @install()

  install: ->
    $(".reload_price").on "change", =>
      from = $('#booking_start_at').get(0)
      to = $('#booking_end_at').get(0)
      rental_id = $('#booking_rental_id').get(0)

      if from.value and to.value and rental_id.value
        @perform("calculate_price", from: from.value, to: to.value, rental_id: rental_id.value)
