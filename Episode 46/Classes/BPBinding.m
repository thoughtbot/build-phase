//
//  BPBinding.m
//  Build Phase Episode 46
//
//  Created by Gordon Fontenot on 7/8/14.
//  Copyright (c) 2014 thoughtbot. All rights reserved.
//

#import "BPBinding.h"
#import "BPTextFieldBinding.h"
#import "BPTextViewBinding.h"

@interface BPBinding ()

@property (nonatomic, readwrite) UIView *view;
@property (nonatomic, readwrite) NSObject *modelObject;
@property (nonatomic, readwrite) NSString *keyPath;
@property (nonatomic, readwrite) NSValueTransformer *transformer;

@end

@implementation BPBinding

+ (instancetype)bindingForTextField:(UITextField *)textField modelObject:(NSObject *)modelObject keyPath:(NSString *)keyPath valueTransformer:(NSValueTransformer *)transformer
{
    return [[BPTextFieldBinding alloc] initWithView:textField modelObject:modelObject keyPath:keyPath valueTransformer:transformer];
}

+ (instancetype)bindingForTextView:(UITextView *)textView modelObject:(NSObject *)object keyPath:(NSString *)keyPath valueTransformer:(NSValueTransformer *)transformer
{
    return [[BPTextViewBinding alloc] initWithView:textView modelObject:object keyPath:keyPath valueTransformer:transformer];
}

- (instancetype)initWithView:(UIView *)view modelObject:(NSObject *)object keyPath:(NSString *)keyPath valueTransformer:(NSValueTransformer *)transformer
{
    self = [super init];
    if (!self) return nil;

    self.view = view;
    self.modelObject = object;
    self.keyPath = keyPath;
    self.transformer = transformer;

    return self;
}

- (void)setDefaultValue:(NSString *)value
{
    [self doesNotRecognizeSelector:_cmd];
}

- (void)viewValueDidChange
{
    [self doesNotRecognizeSelector:_cmd];
}

- (void)updateModelObjectWithValue:(id)newValue
{
    id value = newValue;

    if (self.transformer) {
        value = [self.transformer transformedValue:value];
    }

    [self.modelObject setValue:value forKeyPath:self.keyPath];
}

@end
