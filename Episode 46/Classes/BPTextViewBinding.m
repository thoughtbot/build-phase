//
//  BPTextViewBinding.m
//  Build Phase Episode 46
//
//  Created by Mark Adams on 7/15/14.
//  Copyright (c) 2014 thoughtbot. All rights reserved.
//

#import "BPTextViewBinding.h"

@implementation BPTextViewBinding

- (instancetype)initWithView:(UIView *)view modelObject:(NSObject *)object keyPath:(NSString *)keyPath valueTransformer:(NSValueTransformer *)transformer
{
    self = [super initWithView:view modelObject:object keyPath:keyPath valueTransformer:transformer];
    if (!self) return nil;

    [self setDefaultValue:[object valueForKeyPath:keyPath]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewValueDidChange) name:UITextViewTextDidChangeNotification object:view];

    return self;
}

#pragma mark - BPBinding

- (void)setDefaultValue:(id)value
{
    self.textView.text = value;
}

- (UITextView *)textView
{
    return (UITextView *)self.view;
}

- (void)viewValueDidChange
{
    [self updateModelObjectWithValue:self.textView.text];
}

@end
