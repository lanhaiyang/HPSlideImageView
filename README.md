# HPSlideImageView
## 轮播图
### 下载该项目需要 pod 

```
打开终端
cd 项目的目录
pod install
```

### 1.创建HPSlideImageView
```
 HPSlideImageView *slideImageView=[[HPSlideImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
 
 如果使用Storyboard
 让UIView继承 HPSlideImageView
 
 @property(nonatomic,weak) HPSlideImageView *slideImageView;
 
```
### 2.设置轮播图

```
HPSetObj:设置轮播图样式

hpSetObj.animation  是否开启动画
hpSetObj.style      设置样式
hpSetObj.arrayImage 数据源 UIImage 或  NSString
hpSetObj.bottomColor底部bottom view 颜色
hpSetObj.pageColor  修改 select 的颜色

/**
 修改bottom的位置

 @param addView     添加到那个view
 @param bottomRect  相对于addview的位置
 */
-(void)bottomAddSubview:(UIView *)addView bottomRect:(CGRect)bottomRect;

HPContent:设置改变的状态

content.name        修改bottom view上面的label名字
```

```

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

```
[slideImageView updateLayout];
```
