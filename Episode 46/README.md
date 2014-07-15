Bindings - Sample Code
===

This sample code illustrates a pattern of view/model binding that we've used in projects. This approach is discussed in greater detail in [Episode 46 - A Touch of Class Cluster](http://podcasts.thoughtbot.com/buildphase/46/).

The binding system uses the [Class Cluster pattern](https://developer.apple.com/library/ios/documentation/general/conceptual/CocoaEncyclopedia/ClassClusters/ClassClusters.html). `ONEBinding` serves as the only interface while the "private" subclasses, `ONETextFieldBinding` and `ONETextViewBinding`, actually do the heavy lifting required for observing updates to view values and applying them to the provided model object.

We've included the specs for these classes as well. The specs make use of [Specta](https://github.com/specta/specta), [Expecta](https://github.com/specta/expecta) and [OCMock](http://ocmock.org).

