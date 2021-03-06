# HPSlideImageView

### Pods 

```
#在podfile 中添加

# iOS 版本要7.0 :platform :ios, ‘7.0’
```
```
pod 'HPSlideImageView', '~> 0.0.1'
```

### 轮播图
#### 下载该项目需要 pod 

```
打开终端
cd 项目的目录
pod install
```

### 1.创建HPSlideImageView

```objective-c
HPSlideImageView *slideImageView=[[HPSlideImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
 
 如果使用Storyboard
 让UIView继承 HPSlideImageView
 
 @property(nonatomic,weak) HPSlideImageView *slideImageView;
```

### 2.设置轮播图

#### HPSetObj:设置轮播图样式

- hpSetObj.style        设置样式
- hpSetObj.arrayImage   数据源 UIImage 或  NSString
- hpSetObj.bottomColor  底部bottom view 颜色
- hpSetObj.contentModel 图片显示填充方式
- hpSetObj.pageColor    修改 select 的颜色
- hpSetObj.defaultImage 设置下载时的默认图片

```objective-c

/**
 
 当小于0 为不开启
 当为0  默认运动时间为5s
 当大于0 为设置时间
 
 设置轮播时间
 
 */
@property(nonatomic,assign) NSTimeInterval animationTime;

/**
修改bottom的位置

@param addView     添加到那个view
@param bottomRect  相对于addview的位置
*/
-(void)bottomAddSubview:(UIView *)addView bottomRect:(CGRect)bottomRect;
	
/**
视觉差异
 
最小为0 为没有变化
最大为1 视觉差最大化
 
数值为  0~1
*/
@property(nonatomic,assign) CGFloat visionDifference;        
```

### visionDifference 视觉差效果

![image](https://github.com/lanhaiyang/HPSlideImageView/blob/master/README/visionAnimation.gif)

#### HPContent:设置改变的状态

- content.name        修改bottom view上面的label名字 


### 初始化HPSlideImageView


```objective-c

    [slideImageView hp_weakObj:self
                 setSlideImage:^HPSetObj *(id weakObj, HPSetObj *hpSetObj) {
                   
                   /*
                   		设置轮播图样式
                   
                   */
                   
                   return hpSetObj;
                   
               } action:^(id weakObj, NSUInteger index) {
               
                   NSLog(@"点击");
                   
               } indexPath:^HPContent *(id weakObj, HPContent *content, NSUInteger index) {
                   
                   NSString *name=weakObj.array[index];
                   content.name=name;
                   /*
                   		设置当前改变UIIamge的name
                   
                   */
                   return content;
                   
               }];   
                           
    
```
### 请求到数据更新轮播图

```objective-c
[slideImageView updateLayout];
```
