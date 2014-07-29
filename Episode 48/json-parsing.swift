// swiftz gives us the basic JSON parsing, as well as
// the apply (<*>), fmap (<^>), and bind (>>=) operators
import swiftz
import swiftz_core

extension User: JSON {
    // We need this because we can't pass an object's constructer
    // as a function. This is also needed to be able to curry the
    // construction
    static func create(id: Int) -> String -> String -> User {
        return { name in { email in User(id: id, name: name, email: email) } }
    }

    // If any of these don't parse properly, the entire thing fails,
    // and we get back .None
    public static func fromJSON(x: JSValue) -> User? {
        switch x {
        case let .JSObject(d):

            // This is the create method from above, called without
            // arguments, and passed into fmap
            return create <^>

                // Apply chains these parsing operations together,
                // ensuring that the entire thing needs to succeed
                (d["id"] >>= JInt.fromJSON) <*>
                (d["name"] >>= JString.fromJSON) <*>
                (d["email"] >>= JString.fromJSON)

        default:
            return .None
        }
    }
}
