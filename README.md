windowtest
==========

Patch test-in-browser for testing code in multiple browser windows.

The tests need to open child windows, but to reduce annoying pop-ups
browsers will ignore `window.open()` unless called from a callback
from a user event such as clicking a button.

This package adds a "Run Tests" button, and delays running tests until
the button is pressed.  Since the test code is now called from a click
callback, the test code is able to open child windows.
