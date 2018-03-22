$ ->
  delay = do ->
    timer = 0
    (callback, ms) ->
      clearTimeout timer
      timer = setTimeout(callback, ms)
      return
  
  $(document).on 'keyup', '#search_phrase', ->
    phrase = $(@).val().trim()
    delayTime = 1000
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
    if confirm('Are you sure?')
      $.ajax
        type: 'POST'
        url: '/clear_analytic'
        dataType: 'script'
      return false
    else
      return false

