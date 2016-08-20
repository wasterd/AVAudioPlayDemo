//
//  ViewController.h
//  AVAudioPlayerDemo
//
//  Created by liuYaLin on 16/8/20.
//  Copyright © 2016年 微创软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController<AVAudioPlayerDelegate>

{
    //播放按钮
    UIButton *_playButton;
    //暂停按钮
    UIButton *_pauseButton;
    //停止按钮
    UIButton *_stopButton;
    //音乐进度条
    UIProgressView *_progressView;
    //声音控制条
    UISlider *_slider;
    //静音开关
    UISwitch *_vomumOn;
    
    //音频播放器对象
    AVAudioPlayer *_player;
    
    //定义一个定时器对象
    NSTimer *_timer;
}

@end

