#import "BPTextViewBinding.h"

SpecBegin(BPTextViewBinding)

describe(@"BPTextViewBinding", ^{
    describe(@"initialization", ^{
        it(@"registers for the UITextViewTextDidChange notification", ^{
            id notificationCenterMock = OCMPartialMock([NSNotificationCenter defaultCenter]);
            UITextView *textView = [UITextView new];

            BPTextViewBinding *binding = [[BPTextViewBinding alloc] initWithView:textView modelObject:nil keyPath:nil valueTransformer:nil];

            OCMVerify([notificationCenterMock addObserver:binding selector:@selector(viewValueDidChange) name:UITextViewTextDidChangeNotification object:textView]);

            [notificationCenterMock stopMocking];
        });

        context(@"when the model has a value at the provided key path", ^{
            it(@"sets the default value for the text field from the model object", ^{
                UITextView *textView = [UITextView new];
                NSDictionary *dictionary = @{@"foo": @"bar"};
                NSString *keyPath = @"foo";

                __unused BPTextViewBinding *binding = [[BPTextViewBinding alloc] initWithView:textView modelObject:dictionary keyPath:keyPath valueTransformer:nil];

                expect(textView.text).to.equal(@"bar");
            });
        });
    });

    describe(@"setDefaultValue", ^{
        context(@"when provided a default value", ^{
            it(@"sets the text attribute on the text view", ^{
                UITextView *textView = [UITextView new];
                BPTextViewBinding *binding = [[BPTextViewBinding alloc] initWithView:textView modelObject:nil keyPath:nil valueTransformer:nil];

                [binding setDefaultValue:@"foo"];

                expect(binding.textView.text).to.equal(@"foo");
            });
        });

        context(@"when not provided a default value", ^{
            it(@"resets the text attribute on the text view to nil", ^{
                UITextView *textView = [UITextView new];
                BPTextViewBinding *binding = [[BPTextViewBinding alloc] initWithView:textView modelObject:nil keyPath:nil valueTransformer:nil];

                [binding setDefaultValue:nil];

                expect(binding.textView.text).to.equal(@"");
            });
        });
    });

    describe(@"the binding behavior", ^{
        context(@"when the view value changes", ^{
            it(@"updates the bound model object", ^{
                UITextView *textView = [UITextView new];
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                NSString *keyPath = @"foo";
                BPTextViewBinding *binding = [[BPTextViewBinding alloc] initWithView:textView modelObject:dictionary keyPath:keyPath valueTransformer:nil];

                textView.text = @"bar";
                [binding viewValueDidChange];

                expect(dictionary[keyPath]).to.equal(@"bar");
            });
        });
    });
});

SpecEnd
