class @Disqus
  constructor: (@shortName) ->

  loadComments: (options) ->
    unless @shortName
      console.log 'Disqus needs a shortname. eg disqus = new Disqus(shortname)'
      return
    
    if options
      {identifier, title, url} = options
    else
      options = {}

    if DISQUS?
      DISQUS.reset
        reload: true
        config: ->
          @page.identifier = options.identifier
          @page.title      = options.title
          @page.url        = options.url || window.location.href
    else
      window.disqus_shortname = @shortName
      window.disqus_identifier = options.identifier
      window.disqus_title = options.title
      window.disqus_url = options.url || window.location.href
      dsq = document.createElement 'script'
      dsq.id = "dsq"
      dsq.type = 'text/javascript'
      dsq.async = true
      dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js'
      document.getElementsByTagName('head')[0].appendChild(dsq)

  loadCounts: ->
    unless @shortName
      console.log 'Disqus needs a shortname. eg disqus = new Disqus(shortname)'
      return

    window.disqus_shortname = @shortName
    window.DISQUSWIDGETS = undefined
    $.getScript("http://" + @shortName + ".disqus.com/count.js")
