# Task Test 

An example iOS project created to learn about Tasks. The plan:

1. Learn the basics of Tasks.
2. Preliminary acquaintace with Actors


## Demos

1. Task Demo - Simple demo of starting and canceling tasks.
2. Actor Demo - Attempt at demonstrating a use case of Actors but it doesn't demonstrate the race-condition problems Actors try to solve.


## Notes

### Actor Demo

```
[Attach Video Demo]
```

This demonstration is actually a pretty good one because it explains (and attacks) the concept we're trying to grab here. If we draw the timeline of how things happen it will look like this:

```
T0 - actor's update() method is called [x]. Sleep() is a suspension point.
T1 - actor's update() method is called [y]. Sleep() is a suspension point.
T2 - actor's update() method is called [z]. Sleep() is a suspension point.
T3 - [x] returns. reads the value of counter (0) and increments it to 1.
T4 - [y] returns. reads the value of counter (1) and increments it to 2.
T5 - [z] returns. reads the value of counter (2) and increments it to 3.
T6 - value of the count is read as 3 for the 1st label.
T7 - value of the count is read as 3 for the 2nd label.
T8 - value of the count is read as 3 for the 3rd label.
```

But when it comes to the Class implementation:


```
T0 - class's update() method is called [x]. Sleep() is a suspension point.
T1 - class's update() method is called [y]. Sleep() is a suspension point.
T2 - class's update() method is called [z]. Sleep() is a suspension point.
T3 - [x] returns. reads the value of counter (0) and increments it to 1.
T4 - value of the count is read as 1 for the 1st label.
T5 - [y] returns. reads the value of counter (1) and increments it to 2.
T6 - value of the count is read as 2 for the 2nd label.
T7 - [z] returns. reads the value of counter (2) and increments it to 3.
T8 - value of the count is read as 3 for the 3rd label.
```

Now the real question is, how (or why) in the actor implementation did the __READs__ ALL happen after the update operations from ALL tasks complete? It has to do with one extra keyword that's required (by design of actors):

```swift
Task{
    try await actorState.update()
    vm.counter1 = await actorState.count
    //            ^^^^^         the secret sauce!
}
```

The easiest way to wrap your head around this concept is that the read of the actorState.count property is a 'message' sent to the Actor's mailbox which is maintained as a queue of operations. Comparing the Tx(s) from the example the mailbox at each point would loook like this:


```
T0 - [x is waiting]
T1 - [x is waiting][y is waiting]
T2 - [x is waiting][y is waiting][z is waiting]
T3 - [y is waiting][z is waiting][T6 read][T7 read][T8 read]
T4 - [z is waiting][T6 read][T7 read][T8 read]
T5 - [T6 read][T7 read][T8 read]
T6 - [T7 read][T8 read]
T7 - [T8 read]
T8 - Mailbox is empty
``` 

Did you get that? Actors have a mailbox (a queue) that serializes actions from any and all access points. This could mean a function call, a property access or a property read. The messages are controlled. That is why, even though each "update" operation increments __the counter by 1 successfully in both the actor and class instances__, the visible 'read' operation makes a difference into what's perceived.

Now, depending on what's the actual expectation what's considered "correct" may change, but the purpose of this demo is to say that the choice of the construct you use for your concurrent applications have an effect on the final visible output.

> At the time of writing this (2026 February 5th 09:23) I'm late for work and I just wanted to get this bug out of my head. I may never revisit what I've typed above, so please excuse me if it's not to the point or even incorrect entirely.  
