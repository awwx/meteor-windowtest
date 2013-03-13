windowtest
==========

Patch test-in-browser for testing code that runs across multiple browser
windows.

The tests need to open child windows, but browsers will ignore
`window.open()` unless called from a callback from a user event
such as clicking a button.

This package adds a "Run Tests" button, and delays running tests until
the button is pressed.  Since the test code is now called from a click
callback it is able to open child windows.
