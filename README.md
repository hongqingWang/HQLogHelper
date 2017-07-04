![](http://upload-images.jianshu.io/upload_images/2069062-71f45a10b6969e90.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 痛点

实际开发过程中，从网络上拿到的数据，再控制台打印输出时，格式是以下形式的：

```objective-c
{
    error = {
        errorCode = 10002;
        errorMessage = "Appkey is missing. (\U65e0appkey\U53c2\U6570)";
    };
    status = ERROR;
}
```

![](http://upload-images.jianshu.io/upload_images/2069062-d3120f8a9da82355.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 存在着以下几点问题

- 双引号`" "`缺失
- `unicode`编码没有显示中文
- 当有数组情况时候，数组的中括号`[ ]`--->变成可恶的圆括号了`( )`

---

## 解决办法

- 写一个`NSDictionary`的`Category`

![](http://upload-images.jianshu.io/upload_images/2069062-bab0e7d30e01af95.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 分类里重写方法`- (NSString *)descriptionWithLocale:(id)locale`

```objective-c
- (NSString *)descriptionWithLocale:(id)locale {

    NSString *string;
    
    @try {
        
        string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
    } @catch (NSException *exception) {
        
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        string = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
        
    } @finally {
        
    }
    
    return string;
}
```

- 返回数据打印样式

```objective-c
{
    "status" : "ERROR",
    "error" : {
        "errorMessage" : "Appkey is missing. (无appkey参数)",
        "errorCode" : 10002
    }
}
```

![](http://upload-images.jianshu.io/upload_images/2069062-23a0bd94af67810a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 解析结果

![](http://upload-images.jianshu.io/upload_images/2069062-2cfd97361230db81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---

## 使用方法

将`HQLogHelper`导入到你的项目中，然后直接运行即可。

![](http://upload-images.jianshu.io/upload_images/2069062-d681d643bb68caf6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---

## 原文

**简书**：[**iOS-打印 JSON 数据原格式**](http://www.jianshu.com/p/d5c734335c34)


---

参考：

- [iOS JSON数据NSLog小技巧](http://www.jianshu.com/p/b6bb983e39da)
