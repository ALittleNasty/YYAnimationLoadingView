# YYAnimationLoadingView
Customize animation loading view


#### 1. AnimationRectLoadingView

使用两个矩形方块做的loading动画, 利用``CAKeyframeAnimation``设置关键帧的动画和``CAAnimationGroup``完成``position`` ``rotation`` ``scale``的组合动画, 这里把``AnimationRectLoadingView``封装成一个单例, 加到``keyWindow``上面. 


* 显示的时候调用:

	``[AnimationRectLoadingView showAnimationLoading];``

* 隐藏loading动画的时候调用

	``[AnimationRectLoadingView dismissAnimationLoading];``


#### 2. PinwheelLoadingView

使用``CAShapeLayer``配合``UIBezierPath``绘制扇形, 完成风车的形状. 用``CABasicAnimation``的``rotation``动画做旋转效果. 这个空间继承自``UIView``, 也是封装为一个单例加到``keyWindow``上面.

* 显示的时候调用

	``[PinwheelLoadingView showAnimationLoading];``

* 隐藏loading动画的时候调用

	``[PinwheelLoadingView dismissAnimationLoading];``即可!