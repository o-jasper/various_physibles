NOTE the status is: Probably it works, but i dont feel like testing or
developing it further. If you try it please provide feedback for others.
(be specific) `clamp_` and `dry_` are more likely to work than `tiny_`.

If i develop it further, i will likely start from scratch.

# Clamps
Clamps inspired on [thingiverse user KidCrazy](http://www.thingiverse.com/KidCrazy/designs)'s
['KCS' clamp](http://www.thingiverse.com/thing:89457). Untested. Intended improvements are:

* Made it parametric.
* Guides to center it.
* Holes to glue some filament on in order to hold a regular spring instead of a
  plastic one.
* (optional, parametric)Gap behind the teeth improves hold on clothing.

## Instructions
Print it, the `_set.stl` files contains a pair with the plastic spring,
`_pair.stl` without. 

Then put the parts together, it will resist a bit halfway due to the guide. 
Going in diagnonally seems to work better.

If you use the plastuc spring, just put it in. Note that plastic is subject to 
[creep](https://en.wikipedia.org/wiki/Creep_%28deformation%29) when under constant tension.

For regular springs there are probably multiple good strategies. 
* use metal wires and twisting them up, the spring then goes over the metal wires.

* fuse bits of filament with the hot end, this was my initial plan 
  but it didnt work well for me.

* You could probably also just tie it with wire but i am not so sure how well 
  that works. 

* Risk using nothing. Spring has friction with the plastic. There are also cones
  where the spring can go.

## Potential improvements
Many; 

* Springs are not properly parametric(actually left out the `dry_spring.stl` because
  it didnt work well)
* Assembly could be easier. (That might mean just turning the guides off)
* Parameters based on what the user want, and that dont require fiddling to get
  right.
* When the distance between the prongs is small relative to the length the
  handles collide, increasing their distance would help.
* More defaults.

## Author
[Jasper den Ouden](http://www.ojasper.nl/), much inspired from
[thingiverse user KidCrazy](http://www.thingiverse.com/KidCrazy/).

As usual development versions [on github](https://github.com/o-jasper/various_physibles).
