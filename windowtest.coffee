# Delay execution of test-in-browser's call to _runTestsEverywhere
# until the "Begin Tests" button is pressed.

originalRunTestsEverywhere = Meteor._runTestsEverywhere

recorded_arguments = null

Meteor._runTestsEverywhere = (onReport, onComplete) ->
  recorded_arguments = {onReport, onComplete}

runTests = ->
  unless recorded_arguments?
    throw new Error "oops, test-in-browser hasn't called _runTestsEverywhere yet"
  originalRunTestsEverywhere recorded_arguments.onReport, recorded_arguments.onComplete

runBeforeTests = null
numberOfWindowsToOpen = 0
childWindows = []

Meteor.windowtest =
  numberOfWindowsToOpen: (n) ->
    numberOfWindowsToOpen = n

  beforeTests: (f) ->
    if runBeforeTests?
      throw new Error "Can't call beforeTests more than once"
    runBeforeTests = f

Template.begin_tests.events
  'click #begin-tests-button': ->
    $('#begin-tests-div').hide()

    for i in [1 .. numberOfWindowsToOpen]
      childWindows[i] = window.open "/child#{i}", "child#{i}",
        'menubar=yes,toolbar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes'

    if runBeforeTests?
      runBeforeTests -> runTests()
    else
      runTests()

Template.begin_tests.show = -> window.location.pathname is '/'

closeChildWindows = ->
  Meteor.BrowserMsg.send 'close windows'

Meteor.autorun (handle) ->
  if not Template.test_table.running() and Template.test_table.passed()
    handle.stop()
    closeChildWindows()

if window.location.pathname isnt '/'
  Meteor.BrowserMsg.listen 'close windows': window.close()
