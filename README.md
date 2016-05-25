# BaseModel
用于将字典数据填充到Model上

#实例代码：
```
        //1.JSON数据
        NSString *json = @"{ \
            \"id\" : 1491520,  \
            \"type\" : 0,   \
            \"title\" : \"科幻大作《全面回忆》全新预告片发布\",  \
            \"summary\" : \"\",  \
            \"image\" : \"http://img31.mtime.cn/mg/2012/06/28/100820.21812355.jpg\" \
        }";
        
        //2.JSON数据解析
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        
        //3.将字典数据填充到Model
        News *news = [[News alloc] initWithDataDic:jsonDic];
        NSLog(@"%@",news);
```
