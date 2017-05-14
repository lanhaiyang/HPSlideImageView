# HPSlideImageView
## 轮播图

### 1.创建HPSlideImageView

```
    HPSlideImageView *slideImageView=[HPSlideImageView new];
    
```
### 2.设置轮播图###
```
HPSetObj:设置轮播图样式

hpSetObj.animation是否开启动画
hpSetObj.style设置样式
hpSetObj.arrayImage数据源 UIImage 或  NSString

HPContent:设置改变是状态
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
                   		设置当前改变UIiamge的name
                   
                   */
                   return content;
                   
               }];
    
```
### 请求到数据更新轮播图
```
[slideImageView updateLayout];
```
