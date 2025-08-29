## Memory Management
A nice video clip to intro to the overall issue: https://hero.handmade.network/episode/code/day626/#4408  

[Untangling Lifetimes: The Arena Allocator](https://www.rfleury.com/p/untangling-lifetimes-the-arena-allocator)  
[@](https://www.rfleury.com/i/70173682/arena-parameterization) good example of how arenas can be passed as parameters  
[@](https://www.rfleury.com/i/70173682/composition-with-more-complex-allocators) great example of a growable entity allocator with a free list  
[@](https://www.rfleury.com/i/70173682/per-thread-scratch-arenas) per-thread scratch arenas  

> "Learning how to work with arenas entirely revolutionized my experience with writing code in C. I almost never think about memory management, these days—it is not particularly more cumbersome than writing in a garbage-collected scripting language. Unlike such a language, however, I know where my memory is coming from, and when it’ll be “released”, and what that even means." - rjf

Solid written overview - https://www.gingerbill.org/article/2019/02/01/memory-allocation-strategies-001/  
Solid implementation walk-thru - https://www.gingerbill.org/article/2019/02/08/memory-allocation-strategies-002/  

## misc

[How I structure my entities](https://youtu.be/UolgW-Ff4bA)

A bunch of [engine programming stuff](https://www.youtube.com/playlist?list=PLmV5I2fxaiCI9IAdFmGChKbIbenqRMi6Z) from JBlow

[Sokol](https://github.com/floooh/sokol) for an easy and solid foundation (platform, input, sound, etc)  

https://easings.net/ - easing functions cheat sheet  

https://gafferongames.com/#posts - lots of goodies in here  

[John Carmack on Functional Programming](http://sevangelatos.com/john-carmack-on/)  

## graphics programming
If I were starting out, I'd just use [Sokol](https://github.com/floooh/sokol) with [sokol-gp](https://github.com/edubart/sokol_gp) instead of worrying about learning graphics programming straight away.  

When ready though...  

https://learnopengl.com/ - especially for the coordinate systems / transformation matrix explanations  

I just use d3d11 since I'm only targeting Windows on Steam since that's around ~98% of users. It simplifies things greatly. One target.  

d3d11 specific:  
http://www.directxtutorial.com/Lesson.aspx?lessonid=11-4-1 (solid fundamentals)  
https://graphicsprogramming.github.io/learnd3d11/ (might find something useful in here?)  
[basic setup example using the C API](https://gist.github.com/mmozeiko/5e727f845db182d468a34d524508ad5f#file-win32_d3d11-c-L4)  
[Minimal D3D11](https://gist.github.com/d7samurai/261c69490cce0620d0bfc93003cd1052)  
https://github.com/Microsoft/DirectXTK/wiki/Getting-Started - good for examples on the more advanced stuff (ignore the C++ cringe)  
[Shader examples](https://github.com/Microsoft/DirectXTK/tree/main/Src/Shaders)  
[HLSL reference](https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-reference)  
  
some fun - https://alaingalvan.gitbook.io/a-trip-through-the-graphics-pipeline/  

(for correctly mapping a texture without edge bleed)  
https://learn.microsoft.com/en-us/windows/win32/direct3d9/texture-coordinates
https://learn.microsoft.com/en-us/windows/win32/direct3d9/directly-mapping-texels-to-pixels

### lighting
[A better point light attenuation function](https://lisyarus.github.io/blog/graphics/2022/07/30/point-light-attenuation.html)  

## audio programming
Save yourself the pain of writing bytes to a sound buffer and just use [FMOD](https://www.fmod.com). It's unparalleled when it comes to getting soundscapes for games up and running. It's what I'm shipping with in my game.
The other big daddy is Wise, but from what I've seen FMOD is more accessible when starting out.

Now, if you really do want to go down the DIY route because you think it might be fun...

[Lessons Learned from a Decade of Audio Programming](https://www.youtube.com/watch?v=Vjm--AqG04Y) is a banger  

[Introduction to Sound Mixing](https://guide.handmadehero.org/code/day139/)  
[@ -](https://guide.handmadehero.org/code/day139/#1834) mixing sounds together, clipping, modulation & interpolation, pitch  
implementation is in the following days [here](https://guide.handmadehero.org/code/) (from day 139)

https://tek256.com/posts/game-audio/ - decent overview of some of the terms wrt game dev  

[low pass filter](https://dobrian.github.io/cmp/topics/filters/lowpassfilter.html)  
It was at this point that I realised doing it myself is a stupid idea. Writing all these filters from scratch is silly. I wanted more complex mixing at my fingertips, while staying in the game / sound design space (instead of the *engine brain* tooling space)... hence FMOD.

## Ryan Fleury
Ryan deserves his own section because he's an absolute unit of a man.  

[His Substack](https://www.rfleury.com/) is a gold-mine. If you become a member, his community discord is a great place to ask questions and get sensible answers  
[UI Series](https://www.rfleury.com/p/ui-series-table-of-contents)  
[Confronting combinatorics](https://www.rfleury.com/i/54162175/confronting-combinatorics) - flags vs switches  

## Jai Programming
If you're in the beta, the `how_to` is king. Also don't forget to go through *every single module* to get a feel for what's already been done. I was a silly goose and didn't do this, so I ended up writing my own custom arena allocator... only to realise that Flat_Pool was a thing. RIP.

other helpful community stuff:
[The Way to Jai](https://github.com/Ivo-Balbaert/The_Way_to_Jai) - great starting point  
[Jai Community Wiki](https://github.com/Jai-Community/Jai-Community-Library/wiki) - a great reference once finished with the `how_to`'s (and for finding stuff that isn't yet doucmented in them)  

The following is a collection of Jon Nuggets™️

[why RAII is bad](https://www.youtube.com/watch?v=uZgbKrDEzAs&t=603s)

on parsing a custom text file instead of using something like json, found in `"jai\modules\Text_File_Handler\examples\example.jai"`
```
Here, we parse each line of the file. Many programmers in the modern day seem to be afraid
of parsing and fall back on huge libraries that don't even really solve the problem, and
end up giving them a bunch of extra work to do anyway, and that extra work may insidiously
worm its way throughout the program, increasing complexity of the program and reducing its
reliability. (See the typical large program that loads JSON files for an example of this).

In a modern programming language with powerful semantics and reasonable strings and good
compile-time and run-time checking, parsing simple things is pretty easy. It's much nicer
(and leads to more-solid programs) to do this than to try to load some generic uber-format
everywhere. Many people wearing Computer Science University hats will tell you this is
exactly backward, but they are exactly backward.
```

## networking shit
high level overview - https://pvigier.github.io/2019/09/08/beginner-guide-game-networking.html  

Don't bang your head against a wall trying to get around [NAT](https://tailscale.com/blog/how-nat-traversal-works/) from scratch, instead bang your head against a wall while using the [SteamAPI](https://partner.steamgames.com/doc/sdk/api).  

great resource for learning socket fundamentals from scratch - https://beej.us/guide/bgnet/  

if you ever wanna go down the route of a netchad, here's *a lot* more concepts - https://beej.us/guide/bgnet0/

## multithreading
[Introduction to Multithreading](https://guide.handmadehero.org/code/day122)  
[Interlocked Operations](https://guide.handmadehero.org/code/day123/)  
[Memory barriers and semaphores](https://guide.handmadehero.org/code/day124/)  
^ this was enough to get me going with multithreading

## dump
most of this is unread and unsorted  

todo: make a proper linked list  
linked list stuff - https://fgiesen.wordpress.com/2010/09/27/data-structures-and-invariants/  
cycle detection - https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_tortoise_and_hare  

animation stuff - https://www.youtube.com/watch?v=KPoeNZZ6H4s  

https://github.com/Angelo1211/HybridRenderingEngine#references  
[Parallel Computer Architecture and Programming](http://15418.courses.cs.cmu.edu/tsinghua2017/home  )  
[doom 2016 graphics study](https://www.adriancourreges.com/blog/2016/09/09/doom-2016-graphics-study/)  
  

https://gafferongames.com/post/networked_physics_2004/  
https://gafferongames.com/post/udp_vs_tcp/  
https://gafferongames.com/post/sending_and_receiving_packets/  
https://gafferongames.com/post/virtual_connection_over_udp/  
https://gafferongames.com/post/reliability_ordering_and_congestion_avoidance_over_udp/  
https://gafferongames.com/post/what_every_programmer_needs_to_know_about_game_networking/  

https://gafferongames.com/post/introduction_to_networked_physics/  
https://gafferongames.com/post/deterministic_lockstep/  
https://gafferongames.com/post/snapshot_interpolation/  
https://gafferongames.com/post/snapshot_compression/  
https://gafferongames.com/post/state_synchronization/  
https://gafferongames.com/post/networked_physics_in_virtual_reality/  

casey GJK:  
https://www.youtube.com/watch?v=SDS5gLSiLg0&t=2685s  
https://www.youtube.com/watch?v=Qupqu1xe7Io  