//
//  BPBinding.h
//  Build Phase Episode 46
//
//  Created by Gordon Fontenot on 7/8/14.
//  Copyright (c) 2014 thoughtbot. All rights reserved.
//

@interface BPBinding : NSObject

@property (nonatomic, readonly) UIView *view;
@property (nonatomic, readonly) NSObject *modelObject;
@property (nonatomic, readonly) NSString *keyPath;
@property (nonatomic, readonly) NSValueTransformer *transformer;

+ (instancetype)bindingForTextField:(UITextField *)textField modelObject:(NSObject *)modelObject keyPath:(NSString *)keyPath valueTransformer:(NSValueTransformer *)transformer;
+ (instancetype)bindingForTextView:(UITextView *)textView modelObject:(NSObject *)object keyPath:(NSString *)keyPath valueTransformer:(NSValueTransformer *)transformer;

- (instancetype)initWithView:(UIView *)view modelObject:(NSObject *)object keyPath:(NSString *)keyPath valueTransformer:(NSValueTransformer *)transformer;

#pragma mark - Subclassing

- (void)setDefaultValue:(NSString *)value;
- (void)viewValueDidChange;
- (void)updateModelObjectWithValue:(id)newValue;

@end
