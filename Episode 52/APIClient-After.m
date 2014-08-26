typedef void(^APIRequestCompletionBlock)(BOOL successful, id object);
typedef id(^ParsingBlock)(id JSON);

@interface APIClient : NSObject

- (void)performRequest:(NSURLRequest *)request parsingBlock:(ParsingBlock)parsingBlock completionBlock:(APIRequestCompletionBlock)completionBlock;

@end

@implementation APIClient

- (void)performRequest:(NSURLRequest *)request completionBlock:(APIRequestCompletionBlock)completionBlock
{
    [self.networkClient performRequest:request completion:^(id JSON, NSError *error) {
        BOOL success = (error == nil);

        id object;
        if (success) {
            object = parsingBlock(JSON);
        } else {
            [self reportError:error];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) completionBlock(success, object);
        });
    }];
}

- (void)reportError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DidEncounterNetworkError object:error];
}

@end

@implementation APIClient (ExampleEndpointCategory)

- (void)fetchPostsForUser:(User *)user withCompletionBlock:(BOOL success, NSArray *posts)
{
    NSString *path = [NSString stringWithFormat:@"/users/%@/posts", user.remoteID];
    NSURLRequest *request = [RequestFactory getRequestForPath:path];
    [self performRequest:request parsingBlock:^(id object) {
        return [PostFactory postsFromJSON:JSON];
    } completionBlock:completionBlock];
}

@end

