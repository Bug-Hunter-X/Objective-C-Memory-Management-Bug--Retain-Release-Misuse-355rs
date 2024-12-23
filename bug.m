In Objective-C, a tricky bug can arise from the misuse of the `retain` and `release` methods (or their counterparts in ARC).  Consider this scenario:

```objectivec
@interface MyClass : NSObject
@property (nonatomic, retain) NSString *myString;
@end

@implementation MyClass
- (void)dealloc {
    [myString release];
    [super dealloc];
}
@end

// ...in some method...
MyClass *obj = [[MyClass alloc] init];
obj.myString = [[NSString alloc] initWithString: "Hello"];
[obj release]; //Potential memory leak if not handled correctly
```

If `myString` is not properly released before `obj` is deallocated, a memory leak will occur.  This is particularly insidious because the program may run without obvious errors for a while before showing signs of instability due to memory exhaustion.