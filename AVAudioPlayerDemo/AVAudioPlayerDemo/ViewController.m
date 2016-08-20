//
//  ViewController.m
//  AVAudioPlayerDemo
//
//  Created by liuYaLin on 16/8/20.
//  Copyright © 2016年 微创软件. All rights reserved.
//

#import "ViewController.h"


#define AVWIDTH   self.view.frame.size.width
#define AVHEIGHT   self.view.frame.size.height
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  createUI];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)createUI{
    //播放
    _playButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _playButton.frame=CGRectMake(100, 100, 100, 40);
    [_playButton addTarget:self action:@selector(playClicked) forControlEvents:UIControlEventTouchUpInside];
    [_playButton setTitle:@"播放" forState:UIControlStateNormal];
    [self.view addSubview:_playButton];
    //暂停
    _pauseButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _pauseButton.frame=CGRectMake(100, CGRectGetMaxY(_playButton.frame)+50, 100, 40);
    [_pauseButton addTarget:self action:@selector(pauseClicked) forControlEvents:UIControlEventTouchUpInside];
    [_pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
    [self.view addSubview:_pauseButton];
    
    //停止
    _stopButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stopButton.frame=CGRectMake(100, CGRectGetMaxY(_pauseButton.frame)+50, 100, 40);
    [_stopButton addTarget:self action:@selector(stopClicked) forControlEvents:UIControlEventTouchUpInside];
    [_stopButton setTitle:@"停止" forState:UIControlStateNormal];
    [self.view addSubview:_stopButton];
    
    //音乐进度条
    _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_stopButton.frame)+30, AVWIDTH-20, 10) ];
    _progressView.progress=0.0;//default 0.0~1.0
    [self.view addSubview:_progressView];
    
    //声音控制条
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_progressView.frame)+30, AVWIDTH-20, 20) ];
    //设置音量的最大值
    _slider.maximumValue = 100;
    //设置音量的最小值
    _slider.minimumValue = 0;
    //调整声音时的事件
    [_slider addTarget:self action:@selector(volumeChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_slider];
    
    [self createAVPlayer];

}
//创建音乐播放器
-(void)createAVPlayer{
    //获取本地资源mp3文件的方法
    NSString *str=[[NSBundle mainBundle] pathForResource:@"赖伟锋 - 免费金曲" ofType:@"mp3"];
    NSURL *url=[NSURL fileURLWithPath:str];
    _player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil ];
    
    //准备播放，解码工作
    [_player prepareToPlay];
    //循环播放的次数
    //-1无限次数播放
    _player.numberOfLoops=1;
    //设置音量大小
    _player.volume=0.5;
    _player.delegate=self;
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateT) userInfo:nil repeats:YES];
}
//播放完成时调用此方法
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
   //取消定时器
    [_timer invalidate];
}

//播放失败时调用此方法
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)erro{

    
}

-(void)updateT{
    //duration整个时间
    _progressView.progress=_player.currentTime/_player.duration;


}
//播放
-(void)playClicked{

    [_player play];

}
//暂停
-(void)pauseClicked{
    [_player pause];

}
//停止
-(void)stopClicked{

    [_player stop];
    //停止播放时间清零
    _player.currentTime=0;
    
}
//调整音量
-(void)volumeChange:(UISlider *)slider{

    
    
    // 设置音量大小
    _player.volume=slider.value/100;
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
