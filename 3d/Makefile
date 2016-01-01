all: png

png: drumcarder.scad
	# make a large image and scale it down as antialiasing
	/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD drumcarder.scad -o drumcarder.png --imgsize=4000,3000
	mogrify -crop 3000x2000+500+600 -scale 800x600 drumcarder.png

clean:
	rm *.png~*
