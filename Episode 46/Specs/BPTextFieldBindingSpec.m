#import "BPTextFieldBinding.h"
#import "BPNumericStringTransformer.h"

SpecBegin(BPTextFieldBinding)

describe(@"BPTextFieldBinding", ^{
    describe(@"initialization", ^{
        it(@"registers for Editing Did End notifications on the text field", ^{
            UITextField *textField = OCMClassMock([UITextField class]);

            BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:textField modelObject:nil keyPath:nil valueTransformer:nil];

            OCMVerify([textField addTarget:binding action:@selector(viewValueDidChange) forControlEvents:UIControlEventEditingDidEnd]);
        });

        context(@"when the model has a value at the provided key path", ^{
            it(@"sets the default value for the text field from the model object", ^{
                UITextField *textField = [UITextField new];
                NSDictionary *dict = @{@"foo": @"bar"};
                NSString *keyPath = @"foo";

                __unused BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:textField modelObject:dict keyPath:keyPath valueTransformer:nil];

                expect(textField.text).to.equal(@"bar");
            });

            it(@"disables the text field", ^{
                UITextField *textField = [UITextField new];
                NSDictionary *dict = @{@"foo": @"bar"};
                NSString *keyPath = @"foo";

                __unused BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:textField modelObject:dict keyPath:keyPath valueTransformer:nil];

                expect(textField.enabled).to.beFalsy();
            });
        });
    });

    describe(@"setDefaultValue:", ^{
        context(@"when provided a default value", ^{
            it(@"sets the text attribute on the text field", ^{
                UITextField *textField = [UITextField new];
                BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:textField modelObject:nil keyPath:nil valueTransformer:nil];

                [binding setDefaultValue:@"foo"];

                expect([binding.textField text]).to.equal(@"foo");
            });

            it(@"disables the text field", ^{
                UITextField *textField = [UITextField new];
                BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:textField modelObject:nil keyPath:nil valueTransformer:nil];

                [binding setDefaultValue:@"foo"];

                expect(binding.textField.enabled).to.beFalsy();
            });
        });

        context(@"when not provided a default value", ^{
            it(@"resets the text attribute on the text field to nil", ^{
                UITextField *textField = [UITextField new];
                BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:textField modelObject:nil keyPath:nil valueTransformer:nil];

                [binding setDefaultValue:nil];

                expect([binding.textField text]).to.equal(@"");
            });

            it(@"enables the text field", ^{
                UITextField *textField = [UITextField new];
                BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:textField modelObject:nil keyPath:nil valueTransformer:nil];

                [binding setDefaultValue:nil];

                expect(binding.textField.enabled).to.beTruthy();
            });
        });
    });

    describe(@"the binding behavior", ^{
        context(@"when the text field is updated", ^{
            it(@"should update the bound model object", ^{
                UITextField *textField = [UITextField new];
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                NSString *keyPath = @"foo";
                __unused BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:textField modelObject:dictionary keyPath:keyPath valueTransformer:nil];

                textField.text = @"bar";
                [textField sendActionsForControlEvents:UIControlEventEditingDidEnd];

                expect(dictionary[keyPath]).to.equal(@"bar");
            });
        });
    });
});

SpecEnd
