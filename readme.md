# ACNavBarDrawer
--------------------

导航栏抽屉视图

<img src="https://github.com/albertgh/ACNavBarDrawer/raw/master/screenshot_0.9.gif"/>

## Installation

* Drag `ACNavBarDrawer.h` & `ACNavBarDrawer.m` into your project.
* Add **QuartzCore** framework to your project.

```objective-c
    #import "ACNavBarDrawer.h"
```  

## Usage


### Initialization

```objective-c
//-- 先创建按钮信息 ------------------------------------------------------------------
// 小数组第一个为图片名、第二个为按钮名
NSArray *allItems = @[@[@"drawer_msg", @"button1"],
                      @[@"drawer_msg", @"button2"],
                      @[@"drawer_msg", @"button3"],
                      @[@"drawer_msg", @"button4"]];
                      
/** 初始化 */
_drawerView = [[ACNavBarDrawer alloc] initWithView:self.view andItemInfoArray:allItems];
```  


### Open & Close

```objective-c
// 打开抽屉
[_drawerView openNavBarDrawer];

// 收起抽屉
[_drawerView closeNavBarDrawer];
```

### Delegate

```objective-c
// 实现 <ACNavBarDrawerDelegate> 协议

// 设置代理对象
_drawerView.delegate = self;

// 抽屉上按钮事件的回调
-(void)didTapButtonAtIndex:(NSInteger)itemIndex
{    
    NSLog(@"Button %d is clicked.", (itemIndex + 1));

    switch (itemIndex)
    {
        case 0:
        {
            
        }
            break;
            
        // ... 此处省略

        default:
            break;
    }
}

// 可选回调 抽屉视图将要关闭时 的处理
-(void)drawerWillClose
{

}
```

## Requirements

* ARC
* iOS 6/7


## LICENSE

MIT


