$ ->
  startTime = $.now()

  changeCard = (id, name, img) ->
    $(".js-check-form").attr("id", "edit_card_" + id)
    $(".js-original-text").text(name)
    $(".js-original-text-val").val(name)
    $(".js-card-image").attr("src", img)
    $(".js-translated-text").val("")

  $(".js-check-form")
    .submit ->
      fadeFlash()
      endTime = $.now() - startTime
      $(".js-check-time").val(endTime)

    .on("ajax:success", ( e, data, status, xhr) ->
      card = data.card
      if card.id
        console.log("card")
        changeCard(card.id, card.original_text, card.img)
      else
        $(".js-check-form")
          .parent().hide()
          .end()
          .parents(".container").append("<h2>" + card + "</h2>")
    )
