#import "BPBinding.h"
#import "BPTextFieldBinding.h"
#import "BPTextViewBinding.h"
#import "BPNumericStringTransformer.h"

SpecBegin(BPBinding)

describe(@"BPBinding", ^{
    describe(@"bindingForTextField:modelObject:keyPath:valueTransformer:", ^{
        it(@"returns an instance of BPTextFieldBinding", ^{
            BPBinding *binding = [BPBinding bindingForTextField:nil modelObject:nil keyPath:nil valueTransformer:nil];

            expect(binding).to.beKindOf([BPTextFieldBinding class]);
        });

        it(@"creates an instance with the proper parameters", ^{
            UITextField *textField = [UITextField new];
            NSObject *object = [NSObject new];
            NSString *keyPath = @"description";
            NSValueTransformer *valueTransformer = [NSValueTransformer new];

            BPBinding *binding = [BPBinding bindingForTextField:textField modelObject:object keyPath:keyPath valueTransformer:valueTransformer];

            expect(binding.view).to.equal(textField);
            expect(binding.modelObject).to.equal(object);
            expect(binding.keyPath).to.equal(keyPath);
            expect(binding.transformer).to.equal(valueTransformer);
        });
    });

    describe(@"bindingForTextView:modelObject:keyPath:valueTransformer:", ^{
        it(@"returns an instance of BPTextViewBinding", ^{
            BPBinding *binding = [BPBinding bindingForTextView:nil modelObject:nil keyPath:nil valueTransformer:nil];

            expect(binding).to.beKindOf([BPTextViewBinding class]);
        });

        it(@"creates an instance with the proper parameters", ^{
            UITextView *textView = [UITextView new];
            NSObject *object = [NSObject new];
            NSString *keyPath = @"description";
            NSValueTransformer *valueTransformer = [NSValueTransformer new];

            BPBinding *binding = [BPBinding bindingForTextView:textView modelObject:object keyPath:keyPath valueTransformer:valueTransformer];

            expect(binding.view).to.equal(textView);
            expect(binding.modelObject).to.equal(object);
            expect(binding.keyPath).to.equal(keyPath);
            expect(binding.transformer).to.equal(valueTransformer);
        });
    });

    describe(@"updateModelObjectWithValue:", ^{
        it(@"sets the value for the keyPath on the object", ^{
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            NSString *keyPath = @"foo";
            BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:nil modelObject:dict keyPath:keyPath valueTransformer:nil];

            [binding updateModelObjectWithValue:@"bar"];

            expect(dict).to.equal(@{@"foo": @"bar"});
        });

        context(@"when provided a value transformer", ^{
            it(@"uses the transformer to transform the value before setting it on the object", ^{
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                NSString *keyPath = @"foo";
                NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:BPNumericStringTransformerName];
                BPTextFieldBinding *binding = [[BPTextFieldBinding alloc] initWithView:nil modelObject:dict keyPath:keyPath valueTransformer:transformer];

                [binding updateModelObjectWithValue:@123];

                expect(dict).to.equal(@{@"foo": @123});
            });
        });
    });
});

SpecEnd
