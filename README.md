Chess
=====
Authors: Andre Kuney, Paris Yee

An example of well-refactored object-oriented Ruby design. No long methods or super-long classes anywhere.

###Game

The center of the action. Has two Players and an initialized Board. Each turn, it checks if the game is over; if the game isn't over, the action switches to the moving Player, who then updates the Board accordingly.

###Player

We get command-line input from the player (with correct error handling); that input turns into start and end coordinates for a given move. We then make the move on the board (or fail to, and react accordingly).

###Board

Represented by an array of arrays called "rows". Contains the logic for beginning-of-game piece setup, check and checkmate, and simple rendering. Has a deep duping method, because Ruby's built-in approach to duplication doesn't work when there are lots of Pieces around. Most small helper methods are contained here.
