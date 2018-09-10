参考

https://blog.csdn.net/potato512/article/details/51108813
https://blog.csdn.net/potato512/article/details/51108813?locationNum=4&fps=1
https://blog.csdn.net/zhaoyya/article/details/72842017

https://www.jianshu.com/p/82d3f83241f3  ， +1
https://www.jianshu.com/p/db158239f3a4

/////////////////////////

Cocoapods: pod search无法搜索到类库的解决办法
https://www.jianshu.com/p/b5e5cd053464

/////////////////////////

编辑好后最好先验证 .podspec 是否有有效
$ pod spec lint

如果是因为语法错误，验证失败后会给出错误的准确定位，
标记“^”的地方即为有语法错误的地方。

依赖错误
但是，有些非语法错误是不会给出错误原因的。这个时候可以使用“--verbose”来查看详细的验证过程来帮助定位错误。

这种情况下使用 --use-libraries 虽然不会出现错误（error），但是有时候会带来一些警告（waring），警告同样是无法通过验证的。这时可以用 --allow-warnings 来允许警告。

允许警告， 允许库
pod spec lint CNKI_Z_BaseSDK.podspec --verbose --use-libraries --allow-warnings


/////////////////////////

可以查看你已经注册的信息，其中包含你的name、email、since、Pods、sessions，其中Pods为你往CocoaPods提交的所有的Pod！

pod trunk me

添加其他维护者（如果你的pod是由多人维护的，你也可以添加其他维护者）
pod trunk add-owner CNKI_Z_BaseSDK wangxx@cocoapods.org

//////////////////////////

如果你在手动验证 Pod 时使用了 --use-libraries 或 --allow-warnings 等修饰符，那么发布的时候也应该使用相同的字段修饰，否则出现相同的报错。
pod trunk push CNKI_Z_BaseSDK.podspec --use-libraries --allow-warnings

//////////////////////




