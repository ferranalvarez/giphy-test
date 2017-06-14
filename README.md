# giphy-test

COMMENTS:

 - Honestly I think that 2 hours is not enough for doing this exercise. I can't do more with that time.
 - Have to say that I have not used swift in a while so I had to practise a bit before start this exercise.
 - Theres a handicap related with iOS (Android GIF loading is easy) and the support of GIF's (had to find a library and adapt it to Swift 3).

BUGS:

 - I'm using an alternative request instead of the specified on the exercise, because some GIFs obtained may cause the GIF library to fail and crash Xcode.

TODO:

 - Improve memory management on UIImage GIFs.
 - Lazy loading on individual GIFS, so they can load on demand as you scroll instead of waiting for the load of all elements.
 - Pull to refresh.
 - Infinite scroll.
 - Add dejal/loading spinner.
 - Investigate why the library crashes with some gifs.
