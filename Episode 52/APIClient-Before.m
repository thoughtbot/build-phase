typedef void(^APIRequestCompletionBlock)(id JSON, NSError *error);

@interface APIClient : NSObject

- (void)performRequest:(NSURLRequest *)request completionBlock:(APIRequestCompletionBlock)completionBlock;

@end

@implementation APIClient

- (void)performRequest:(NSURLRequest *)request completionBlock:(APIRequestCompletionBlock)completionBlock
{
    [self.networkClient performRequest:request completion:completionBlock];
}

@end

@implementation APIClient (ExampleEndpointCategory)

- (void)fetchPostsForUser:(User *)user withCompletionBlock:(NSArray *posts, NSError *error)
{
    NSString *path = [NSString stringWithFormat:@"/users/%@/posts", user.remoteID];
    NSURLRequest *request = [RequestFactory getRequestForPath:path];
    [self performRequest:request completionBlock:^(id JSON, NSError *error) {
        NSArray *posts = [PostFactory postsFromJSON:JSON];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (completionBlock) completionBlock(posts, error);
        }];
    }];
}

@end
