# vstress

This test is based on a hardware check program.

Here it only tests the video RAM, i.e. saving the value in a RAM location,
writing a new value, comparing that the new value is kept, and restoring
the old value.

This test has shown

a) video memory corruption (esp. colour RAM) before issue #10 was fixed
b) what looks like video read (display) artifacts while running the tests

Both types of errors were (and are) not detected by the original test.

Note that to check for memory corruption (which is not detected by the test
itself, every 64 iterations the tests wait for a moment for a visual
inspection of the screen.

