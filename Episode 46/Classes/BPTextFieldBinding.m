//
//  BPTextFieldBinding.m
//  Build Phase Episode 46
//
//  Created by Mark Adams on 7/15/14.
//  Copyright (c) 2014 thoughtbot. All rights reserved.
//

#import "BPTextFieldBinding.h"

@implementation BPTextFieldBinding

- (instancetype)initWithView:(UIView *)view modelObject:(NSObject *)object keyPath:(NSString *)keyPath valueTransformer:(NSValueTransformer *)transformer
{
    self = [super initWithView:view modelObject:object keyPath:keyPath valueTransformer:transformer];
    if (!self) return nil;

    [self setDefaultValue:[object valueForKeyPath:keyPath]];
    [self.textField addTarget:self action:@selector(viewValueDidChange) forControlEvents:UIControlEventEditingDidEnd];

    return self;
}

#pragma mark - BPBinding

- (void)setDefaultValue:(NSString *)value
{
    self.textField.text = value;
    self.textField.enabled = !value;
}

- (void)viewValueDidChange
{
    [self updateModelObjectWithValue:self.textField.text];
}

#pragma mark - Public

- (UITextField *)textField
{
    return (UITextField *)self.view;
}

@end
