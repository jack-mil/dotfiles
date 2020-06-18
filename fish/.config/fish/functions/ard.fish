# Defined in /tmp/fish.2KC9W5/ard.fish @ line 2
function ard --argument SKETCH
	set ARCH arduino:avr:nano
	arduino-cli compile -b $ARCH $SKETCH;
	and arduino-cli upload -p /dev/ttyUSB0 -b $ARCH $SKETCH
end
