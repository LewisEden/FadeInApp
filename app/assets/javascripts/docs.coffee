APPID    = "422246492781"
CLIENTID = "422246492781-206g24cfc0hk50vtsd99j8npgcn3v0ui.apps.googleusercontent.com"

_client = null

$(document).on "turbolinks:load", ->
  console.log "hiya"
  
  $('#title').on 'focusout', ->
    TITLE = $(@).val()
  
  $('#submitButton').click ->
    if $('#screenplay').is(':checked')
      _client = new rtclient.RealtimeLoader
        appId:                  APPID
        clientId:               CLIENTID
        authButtonElementId:    'auth'
        autoCreate:             true
        defaultTitle:           'Screenplay'
        initializeModel:        initializeScreenplay
      _client.start ->
        $('#auth').addClass 'disabled'
      console.log "screenplay is ticked"
    if $('#call-sheet').is(':checked')
      _client = new rtclient.RealtimeLoader
        appId:                  APPID
        clientId:               CLIENTID
        authButtonElementId:    'auth'
        autoCreate:             true
        defaultTitle:           'Call Sheet'
        initializeModel:        initializeScreenplay
      _client.start ->
        $('#auth').addClass 'disabled'
    console.log "creating"
    _client.createNewFileAndRedirect
    
  # Open button click
  $('#btn-open').click ->
    return      if $('#btn-open').hasClass 'disabled'
    $('#btn-auth').addClass 'disabled'
    $('#btn-create').addClass 'disabled'
    $('#btn-open').addClass 'disabled'
    $('#btn-share').addClass 'disabled'
    google.load 'picker', '1', callback: ->
      token = gapi.auth.getToken().access_token
      view = new google.picker.View(google.picker.ViewId.DOCS)
      view.setMimeTypes("application/vnd.google-apps.drive-sdk." + APPID)
      picker = new google.picker.PickerBuilder()
        .enableFeature(google.picker.Feature.NAV_HIDDEN)
        .setAppId(APPID)
        .setOAuthToken(token)
        .addView(view)
        .addView(new google.picker.DocsUploadView())
        .setCallback(openCallback)
        .build()
      picker.setVisible(true)
  
# Initialize model
initializeScreenplay = (model) ->
  markdown = model.createString('This SCnreeplay');
  model.getRoot().set('markdown', markdown);
  
initializeCallSheet = (model) ->
  markdown = model.createString('This call sheet');
  model.getRoot().set('markdown', markdown);
  
