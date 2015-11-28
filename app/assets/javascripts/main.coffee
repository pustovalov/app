$ ->
  startTime = $.now()

  $(".js-check-form").submit ->
    endTime = $.now() - startTime
    $(".js-check-time").val(endTime)
