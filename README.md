# Hi!
I'd like to start by thanking you for considering me for this position, I've had a lot of fun coding this test. I learned a lot as well since I used some of your frameworks to make it. 

Paradoxally, this test was demanding to make yet easy to mentally prepare, in the sense that there's a lot of info I knew a lot about the technologies, libraries and strategies the iOS team is currently implementing. I wanted to learn how to work like your team does and I'm grateful for all I've learned.

Regardless of the outcome of this test I would quite like to have a chat with one of your team members. I've some questions that came up and I would love to hear your opinion. 

### Requirements
* Xcode 10
* Swift 4.2
* CocoaPods (for dependency management)

### Installation:
Just clone the repository, run `pod install` and you're all set.

### Dependencies (via CocoaPods):
* ReactiveSwift
* ReactiveFeedback
* Bento
* BentoKit
* StyleSheets
* Tagged

#### Features:
* ✅ Swift 4.2
* ✅ ReactiveSwift
* ✅ Flow controllers (with MVVM and stores)
* ✅ ReactiveFeedback
* ✅ Bento
* ✅ Custom networking layer
* ✅ Custom persistence layer
* ✅ Function composition
* ✅ Unit tests
* ✅ Logging (via os_log)

### Some considerations:

#### Architecture:
I'm aware that you're not using "vanilla" FlowCoordinators; I tried to learn as much as I could about your architecture using [conference talks](https://www.youtube.com/watch?v=szUK4kuFts8) and [blog posts](https://ilya.puchka.me/implementing-features-with-reactivefeedback/). I think the outcome was quite good but I'm also aware that I may have missed some details. Nevertheless, I became a fan of Flow Controllers and will be using this approach in the future.

### Weak spots:
#### ReactiveFeedback.
To be entirely honest, I am not 100% happy with my implementation of ReactiveFeedback. I tried to add a retry button to the UIAlertController that pops up whenever a user doesn't have network connectivity (and tried to load the post feed) but I was unable to get it working in the current timeframe; the same goes for a loading screen.

Additionally, if the user tapped on a post and then went back to the feed I needed to update the current status. 
The problem is that there's no direct connection between ReaderViewController (which I'm using to control the post details, aka whenever a user wants to see an expanded post) and FeedViewController -> FeedViewModel -> FeedFlowController+Renderer.
I was faced with three choices:

1. Pass along a delegate or an observer (which I didn't really because I wanted the builders to be as simple and isolated as possible) and call it / send an event whenever the user went back

or

2. Use notifications to broadcast that the post was being dismissed. This is, in my honest opinion, acceptable given that we can explicitly monitor this notification only in the FeedViewController and react accordingly via a mock user-action. The notification only gets triggered whenever that particular ViewController is dismissed and `isMovingFromParent` so I think we shouldn't run into any problems. I would love to get some feedback on this though!

I could have also just reset the state whenever the FeedViewController detected that the view has been displayed again 🤢. I am very much against this approach. It would effectively go against ReactiveFeedback's fundamental belief that the state is the single-source of truth so this was off-the-table, in my honest opinion.

### Stuff I had planned (but didn't have time to do):
* [How to Control the World](https://vimeo.com/291588126)
* More unit tests
* Prettier UI
