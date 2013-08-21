@protocol BPModelFactory <NSObject>

- (id)objectFromDictionary:(NSDictionary *)dictionary;

@end

@interface BPUserModelFactory : NSObject <BPModelFactory>

@end

@implementation BPUserModelFactory

- (id)objectFromDictionary:(NSDictionary *)dictionary
{
    BPUser *user = [[BPUser alloc] init];
    user.name = dictionary[@"name"];
    user.email = dictionary[@"email"];
    return user;
}

@end

@interface BPUserRequestFactory : NSObject

// Creates an instance of BPURLRequest (some generic request object subclass).
// This request holds onto an instance of the model factory above. Since the
// request knows what endpoint it is hitting, it can be responsible for
// creating the appropriate model factory for the request.
- (BPURLRequest *)requestForUserWithID:(NSNumber *)userID;

@end

@implementation BPUserRequestFactory

- (BPURLRequest *)requestForUserWithID:(NSNumber *)userID
{
    NSString *path = [NSString stringWithFormat:@"user/%@", userID];
    BPURLRequest *request = [[BPURLRequest alloc] initWithPath:path modelFactory:[[BPUserModelFactory alloc] init]];
    return request;
}

@end

@interface BPAPIRequest : AFHTTPClient

// This is the one problem with this technique. Because the information about
// the return object is stored in the request itself, the API client doesn't
// provide type information for the success block. Obviously this can be cast
// when using the method (in this case, to BPUser), but you don't get any help
// from code completion here.
typedef void (^BPAPISuccessBlock)(id result);

- (void)performRequest:(BPURLRequest *)request success:(BPAPISuccessBlock)success;

@end

@implementation BPAPIRequest

- (void)performRequest:(BPURLRequest *)request success:(BPAPISuccessBlock)success
{

    AFJSONRequestOperation *requestOperation =
        [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            // Here, we can call the success block and pass back the parsed object from the model factory.
             success([request.modelFactory objectFromDictionary:JSON]);
        }];

        [self enqueueHTTPRequestOperation:requestOperation];
}

@end
