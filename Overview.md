GifsViewer project overview

Architecture:

I decided to use a Clean Swift architecture for this project.

Advantages of Clean Swift:
#1 Ready-made templates;
#2 Unidirectional flow of data;
#3 Testability;
#4 Reusability;
#5 Collaboration.

Clean Swift is a smart and effective solution for long-term projects, projects with a generous amount of logic and projects you want to reuse in the future.
Maybe it’s not the best solution for small project but it’s one of the best solutions for project that will grow up and stay reusable, testable & readable for other developers.

Third party libraries:

#1 Alamofire:

I decided to use an Alamofire as an elegant and composable way to interface to HTTP network requests. At the core of the system is URLSession and the URLSessionTask subclasses. Alamofire wraps these APIs, and many others, in an easier to use interface and provides a variety of functionality necessary for modern application development using HTTP networking. 

#2 SwiftyGif:

I decided to use a SwiftyGif as a high performance & easy to use Gif engine.

There are main advantages of this choice:
 - UIImage and UIImageView extension based;
 - Remote Gifs;
 - Great CPU/Memory performances.
