
# Parametric bearing
Bearing in two halves with (optional)ball guider. Balls can be bb-gun balls.

Dont risk anything on it, but seems to be able to work 'okey' if the loads is
not too high. 

### How to use it
The halves currently slide over each other, the friction and lines of
extrusion hold them together okey-ish but not ruggedly enough, You could
glue the halves together or tape around the whole thing. 

Designs of objects that use them could also hold the halves together.

### Other ways to use it
The above is merely what i would currently advise, there are other ways. 
The `Makefile` separates between cases, outputting the respective files, it
basically lists them if you read the file.

Filenames also exactly match openscad `module` names.

* `make vertslide` is the above.

* `make vertslide_no_huide` is the same as vertslide, except it makes version 
  without guides.

* `make insert_halfway` outputs a single model with which you have to insert balls
  halfway the print. Note that the hot end may collide with the balls.
  
* `make ringclip` has two half rings and alters the bearing for them to slide
  over
  
* Using the sources directly and having bearing largely build-in. 
  Depends on the item if that is at all wise.

### TODO
* Find standard bearing sizes and provide them as `.stl` from the makefiles.
* Preventing the inside from getting dirt in it?

## License
GPLv3
