//
//  XL_TVPlayerViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_TVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

static CGFloat const kTopviewHeight = 50;
static CGFloat const kBottomviewHeight = 70;


/**
 滑动类型

 - SlidingDirectionType_Default:    默认
 - SlidingDirectionType_Horizontal: 水平滑动
 - SlidingDirectionType_Vertical:   竖直滑动
 */
typedef NS_ENUM(NSInteger, SlidingDirectionType) {
    SlidingDirectionType_Default = 0,
    SlidingDirectionType_Horizontal,
    SlidingDirectionType_Vertical
};


/**
 调节类型

 - ConditionValueType_Default:    默认
 - ConditionValueType_Volume:     调节系统音量
 - ConditionValueType_Brightness: 调节系统亮度
 */
typedef NS_ENUM(NSInteger, ConditionValueType)
{
    ConditionValueType_Default = 0,
    ConditionValueType_Volume,
    ConditionValueType_Brightness
};

@interface XL_TVPlayerViewController ()
//  顶部视图
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *settingBtn;

//  底部视图
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UISlider *moiveProgressSlider;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, assign) CGFloat totalMoiveDuration;

//  播放器
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) UISlider *volumeSlider; //    音量slider

@property (nonatomic, assign) float systemVolume; //    系统音量
@property (nonatomic, assign) float systemBrightness; //    系统亮度
@property (nonatomic, assign) CGPoint startPoint; //    起始位置坐标
@property (nonatomic, assign) float startProgress; //   起始进度
@property (nonatomic, assign) float currentProgress; // 当前进度

@property (nonatomic, strong) NSTimer *avTimer; //  监控进度

@property (nonatomic, assign) ConditionValueType conditionType;
@property (nonatomic, assign) SlidingDirectionType slidingDirection;
@property (nonatomic, assign) BOOL isShowView; //   是否显示top bottom
@end

@implementation XL_TVPlayerViewController
#pragma mark - life cycle method -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prefersStatusBarHidden];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createAVPlayer];
    [self createTopView];
    [self createBottomView];
    [UIView animateWithDuration:0.5 animations:^{
        _topView.alpha = 0;
        _bottomView.alpha = 0;
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MPVolumeView *volumeView = [MPVolumeView new];
    //  系统亮度
    self.systemBrightness = [UIScreen mainScreen].brightness;
    //  系统slider
    for (UIView *v in volumeView.subviews) {
        if ([[v.class description] isEqualToString:@"MPVolumeSlider"]) {
            self.volumeSlider = (UISlider *)v;
            break;
        }
    }
}
#pragma mark - private method -
//  创建播放器
- (void)createAVPlayer
{
    //设置静音状态也可播放声音
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //  frame
    CGRect playerRect = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
    AVURLAsset *asset = [AVURLAsset assetWithURL:self.addressURL];
    //  播放总时长
    Float64 totalDuration = CMTimeGetSeconds(asset.duration);
    self.totalMoiveDuration = totalDuration;
    
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    // layer
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = playerRect;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:playerLayer];
}
//  创建顶部视图
- (void)createTopView
{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.backBtn];
    [self.topView addSubview:self.settingBtn];
    [self.topView addSubview:self.titleLabel];
    
    WS(vs);
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 40));
        make.left.equalTo(@10);
        make.centerY.equalTo(vs.topView.mas_centerY);
    }];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 40));
        make.right.equalTo(@(-10));
        make.centerY.equalTo(vs.topView.mas_centerY);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vs.backBtn.mas_right).offset(25);
        make.right.equalTo(vs.settingBtn.mas_left).offset(-25);
        make.centerY.equalTo(vs.topView.mas_centerY);
        make.height.equalTo(@40);
    }];
    
}
//  创建底部视图
- (void)createBottomView
{
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.moiveProgressSlider];
    [self.bottomView addSubview:self.playBtn];
    [self.bottomView addSubview:self.timeLabel];
    WS(vs);
    [self.moiveProgressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@10);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(vs.moiveProgressSlider.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vs.playBtn.mas_right).offset(15);
        make.right.equalTo(@(-15));
        make.top.equalTo(vs.moiveProgressSlider.mas_bottom).offset(10);
        make.height.equalTo(@30);
    }];
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", @"00:00:00", [self getTimeFromDuration:_totalMoiveDuration]];
}

//  允许横屏旋转
- (BOOL)shouldAutorotate
{
    return YES;
}
//  隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//  支持左右旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
//  默认右旋转
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}
#pragma mark - event method -
//  返回
- (void)returnBackAction
{
    WS(vs);
    [self dismissViewControllerAnimated:YES completion:^{
        [vs.avTimer invalidate];
        vs.avTimer = nil;
    }];
}
//  设置
- (void)settingAction:(UIButton *)btn
{}
//  播放/暂停
- (void)playBtnAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    [self playOrStop:btn.selected];
    [UIView animateWithDuration:0.5 animations:^{
        _topView.alpha = 0;
        _bottomView.alpha = 0;
    }];
}
- (void)playOrStop:(BOOL)flag
{
    if (flag)
    {
        //  通过实际百分比获取秒数
        float dragSecond = floorf(_totalMoiveDuration * _currentProgress);
        CMTime currentCMTime = CMTimeMake(dragSecond, 1);
        //  更新到实际秒数
        [self.player seekToTime:currentCMTime];
        //  重启timer
        [_player play];
        self.avTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshUI) userInfo:nil repeats:YES];
    }
    else
    {
        [_player pause];
        [self.avTimer invalidate];
    }
}
//  时间传化 字符串
- (NSString *)getTimeFromDuration:(CGFloat)duration
{
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)duration/3600,(long)duration%3600/60,(long)duration%60];
}
//  刷新UI
- (void)refreshUI
{
    //1.根据播放进度与总进度计算出当前百分比。
    float new = CMTimeGetSeconds(_player.currentItem.currentTime) / CMTimeGetSeconds(_player.currentItem.duration);
    //2.计算当前百分比与实际百分比的差值，
    float DValue = new - _currentProgress;
    //3.实际百分比更新到当前百分比
    _currentProgress = new;
    //4.当前百分比加上差值更新到实际进度条
    self.moiveProgressSlider.value += DValue;
    CGFloat currentDuration = _totalMoiveDuration * _currentProgress;
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", [self getTimeFromDuration:currentDuration], [self getTimeFromDuration:_totalMoiveDuration]];
    
}
//  拖拽开始
- (void)dragBegin
{
    _startProgress = _moiveProgressSlider.value;
}
//  拖拽结束
- (void)dragEnd
{
    //  先暂停
    [self playOrStop:NO];
    //  储存百分比
    _currentProgress = _moiveProgressSlider.value;
    //  在开启
    [self playOrStop:YES];
    [self.playBtn setSelected:YES];
}

#pragma mark - touch event -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (event.allTouches.count == 1)
    {
        CGPoint point = [[touches anyObject] locationInView:self.view];
        _startPoint = point;
        _startProgress = _moiveProgressSlider.value;
        _systemVolume = _volumeSlider.value;
        //   判断触摸屏幕的 左右 半边
        if (point.x < self.view.frame.size.width / 2)
            _conditionType = ConditionValueType_Brightness;
        else
            _conditionType = ConditionValueType_Volume;
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //  屏幕 左边：亮度   右边：音量
    CGPoint location = [[touches anyObject] locationInView:self.view];
    CGFloat changeY = location.y - _startPoint.y;
    CGFloat changeX = location.x - _startPoint.x;
    if (_isShowView) {
        //上下View为显示状态，此时点击上下View直接return
        CGPoint point = [[touches anyObject] locationInView:self.view];
        if ((point.y>CGRectGetMinY(self.topView.frame)&&point.y< CGRectGetMaxY(self.topView.frame))||(point.y<CGRectGetMaxY(self.bottomView.frame)&&point.y>CGRectGetMinY(self.bottomView.frame))) {
            return;
        }
    }
    
    if (_slidingDirection == SlidingDirectionType_Horizontal)
    {
        if (changeX > 0)
            [_moiveProgressSlider setValue:(_startProgress + abs((int)changeX) / 10 * .008) animated:YES];
        else
            [_moiveProgressSlider setValue:(_startProgress - abs((int)changeX) / 10 * .008) animated:YES];
    }
    else if (_slidingDirection == SlidingDirectionType_Vertical)
    {
        if (_conditionType == ConditionValueType_Brightness) // 亮度
        {
            if (changeY > 0)
                [UIScreen mainScreen].brightness = _systemBrightness - abs((int)changeY) / 10 * .01;
            else
                [UIScreen mainScreen].brightness = _systemBrightness - abs((int)changeY) / 10 * .01;
        }
        else if (_conditionType == ConditionValueType_Volume) // 音量
        {
            if (changeY > 0)
                [_volumeSlider setValue:(_systemVolume - abs((int)changeX) / 10 * .05) animated:YES];
            else
                [_volumeSlider setValue:(_systemVolume + abs((int)changeX) / 10 * .05) animated:YES];
            
            [_volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
    else
    {
        if (fabs(changeX) > fabs(changeY))
            self.slidingDirection = SlidingDirectionType_Horizontal; // 水平方向
        else
            self.slidingDirection = SlidingDirectionType_Vertical; //   竖直方向
    }
    
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (_slidingDirection != SlidingDirectionType_Default)
    {
        self.slidingDirection = SlidingDirectionType_Default;
        CGFloat changeX = point.x - _startPoint.x;
        CGFloat changeY = point.y - _startPoint.y;
        
        //  如果位置改变
        if (fabs(changeX) > fabs(changeY)) {
            [self dragEnd];
        }
        return;
    }
    
    if (_isShowView)
    {
        //上下View为显示状态，此时点击上下View直接return
        if ((point.y>CGRectGetMinY(self.topView.frame)&&point.y< CGRectGetMaxY(self.topView.frame))||(point.y<CGRectGetMaxY(self.bottomView.frame)&&point.y>CGRectGetMinY(self.bottomView.frame))) {
            return;
        }
        _isShowView = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _topView.alpha = 0;
            _bottomView.alpha = 0;
        }];
    }
    else
    {
        _isShowView = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _topView.alpha = .8;
            _bottomView.alpha = .8;
        }];
    }
}
#pragma mark - setter and getter -
- (UIView *)topView
{
    if (!_topView) {
        UIView *v = [UIView new];
        v.frame = CGRectMake(0, 0, kScreenHeight, kTopviewHeight);
        v.backgroundColor = RGBA(235, 235, 235, 1);
        v.alpha = .8f;
        _topView = v;
    }
    return _topView;
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        UIButton *btn = [UIButton new];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexChangeFloat:@"ff5607"] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(18);
        [btn addTarget:self action:@selector(returnBackAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn = btn;
    }
    return _backBtn;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *lb = [UILabel new];
        lb.textColor = [UIColor whiteColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = kFont(17);
        lb.backgroundColor = [UIColor clearColor];
        _titleLabel = lb;
    }
    return _titleLabel;
}
- (UIButton *)settingBtn
{
    if (!_settingBtn) {
        UIButton *btn = [UIButton new];
        [btn setTitle:@"设置" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexChangeFloat:@"ff5607"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
        _settingBtn = btn;
    }
    return _settingBtn;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        UIView *v = [UIView new];
        v.frame = CGRectMake(0, kScreenWidth - kBottomviewHeight, kScreenHeight, kBottomviewHeight);
        v.backgroundColor = RGBA(235, 235, 235, 1);
        v.alpha = .8f;
        _bottomView = v;
    }
    return _bottomView;
}
- (UIButton *)playBtn
{
    if (!_playBtn) {
        UIButton *btn = [UIButton new];
        [btn setTitle:@"播放" forState:UIControlStateNormal];
        [btn setTitle:@"暂停" forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor hexChangeFloat:@"ff5607"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _playBtn = btn;
    }
    return _playBtn;
}
- (UISlider *)moiveProgressSlider
{
    if (!_moiveProgressSlider) {
        UISlider *slider = [UISlider new];
        [slider setMinimumTrackTintColor:[UIColor whiteColor]];
        [slider setMaximumTrackTintColor:RGBA(.49, .48, .49, 1)];
        [slider setThumbImage:[UIImage imageNamed:@"progressThumb.png"] forState:UIControlStateNormal];
        [slider addTarget:self action:@selector(dragBegin) forControlEvents:UIControlEventTouchDown];
        [slider addTarget:self action:@selector(dragEnd) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel];
        _moiveProgressSlider = slider;
    }
    return _moiveProgressSlider;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(14);
        lb.textAlignment = NSTextAlignmentCenter;
        _timeLabel = lb;
    }
    return _timeLabel;
}
@end
