##项目名称
* JingChengWirelessOrderForDishes
</br></br>

##运行环境
* iOS 8.0+ / Mac OS X 10.11+ 
* Xcode 8.0+ 
* Swift 3.0+ 
</br></br>

##项目需求
![image text](http://ac-otjqboap.clouddn.com/acb9c9f6af2426df1cc5.jpg)</br></br>

##项目结构
![image text](http://ac-otjqboap.clouddn.com/43e1ee620c53f4443b92.png)</br></br>
##运行效果</br>
![image text](http://ac-otjqboap.clouddn.com/007b491b6678522545f7.gif)</br></br>

##已完成的功能
* 完成了菜谱模块
* 完成了已点模块
* 完成了菜谱页面点菜功能，增加份数，减少份数，查看详情，更新已点角标份数
* 完成了已点页面的已点为空和已点菜品列表切换，增加份数，减少份数，更新价格，删除一道菜，重新开台，下单功能
</br>

##解决的问题
* 解决了菜品页面的leaks 
* 解决了已点页面的Zombie对象
* 优化了代码结构，重构了代码
* 解决了程序退出到后台，然后重新进入前台，点击加号按钮的时候，屏幕出现刷屏的BUG
* 缓存了每次请求的数据，如果没有网的情况下，会自动加载缓存数据。而且对图片的加载，进行了优化，减少了图片重复加载的次数。
* 给点击图片弹出详情做了弹出动画，保证了安卓端和ios端动画的一致性。


##关于作者
* Edit by [张旭](https://github.com/BrisyIOS)



