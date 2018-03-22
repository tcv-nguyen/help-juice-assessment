$ ->
  delay = do ->
    timer = 0
    (callback, ms) ->
      clearTimeout timer
      timer = setTimeout(callback, ms)
      return
  
  $(document).on 'keyup', '#search_phrase', ->
    phrase = $(@).val()
    delayTime = 750
    minimumWord = 4

    if phrase.split(' ').length >= minimumWord
      delay (->
        $.ajax
          type: 'POST'
          url: '/analytic'
          dataType: 'script'
          data:
            phrase: phrase
        return
      ), delayTime
    return

  $('#clear_analytic').click ->
    $.ajax
      type: 'POST'
      url: '/clear_analytic'
      dataType: 'script'

    return false

