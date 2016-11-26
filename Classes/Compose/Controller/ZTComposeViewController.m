//
//  ZTComposeViewController.m
//  ZT微博
//
//  Created by 张涛 on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZTComposeViewController.h"
#import "ZTTextView.h"
#import "ZTComposeToolBar.h"

#import "ZTComposeTool.h"
#import "MBProgressHUD+MJ.h"
#import "ZTComposePhotosView.h"
#import "ZTEmotionKeyboard.h"
#import "ZTEmotion.h"
#import "ZTEmotionTextView.h"


@interface ZTComposeViewController ()<UITextViewDelegate, ZTComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) ZTEmotionTextView *textView;

/** 键盘顶部的工具条 */
@property (nonatomic, weak) ZTComposeToolBar *toolBar;

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;

/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) ZTComposePhotosView *photosView;

#warning 一定要用strong
/** 表情键盘 */
@property (nonatomic, strong) ZTEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;


@end

@implementation ZTComposeViewController

#pragma mark - 懒加载
- (ZTEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[ZTEmotionKeyboard alloc] init];
        // 键盘的宽度
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 258;
//        self.emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}


- (NSMutableArray *)images{
    
    if (_images == nil) {
        
        _images = [[NSMutableArray alloc] init];
        
    }
    
    return _images;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    //添加导航条
    [self setUpNavgationBar];
    
    //添加TextView
    [self setUpTextView];
    
    //添加工具条
    [self setUpToolBar];
    
    //添加视图相册
    [self setUpPhotosView];
}

// 添加相册视图
- (void)setUpPhotosView
{
    ZTComposePhotosView *photosView = [[ZTComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    
    _photosView = photosView;
    
    [_textView addSubview:photosView];
    
}

- (void)keyboardFrameChange:(NSNotification *)note{
    
    // 如果正在切换键盘，就不要执行后面的代码
    if (self.switchingKeybaord) return;
    
    // 获取键盘弹出的动画时间
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform =  CGAffineTransformIdentity;
        }];
    }else{ // 弹出键盘
        // 工具条往上移动258
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }


}

- (void)setUpToolBar{

    CGFloat h = 35;
    
    CGFloat y = self.view.height - h;
    
    ZTComposeToolBar *toolBar = [[ZTComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    
    toolBar.delegate = self;
    
    _toolBar = toolBar;
    
    [self.view addSubview:toolBar];

}

#pragma mark - ZTComposeToolbarDelegate
- (void)composeToolbar:(ZTComposeToolBar *)toolbar didClickButton:(ZTComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case ZTComposeToolbarButtonTypeCamera: // 拍照
            [self openCamera];
            break;
            
        case ZTComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case ZTComposeToolbarButtonTypeMention: // @
            ZTLog(@"--- @");
            break;
            
        case ZTComposeToolbarButtonTypeTrend: // #
            ZTLog(@"--- #");
            break;
            
        case ZTComposeToolbarButtonTypeEmotion: // 表情\键盘
            [self switchKeyboard];
            ZTLog(@"--- 表情");
            break;
    }
}

/**
#pragma mark - 点击工具条的时候调用
- (void)composeToolBar:(ZTComposeToolBar *)toolBar didClickBtn:(NSInteger)index{

    if (index == 0) {
        
        // 弹出系统的相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置相册类型,相册集
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }

}
 */

#pragma mark - 选择完图片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    
    _photosView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _rightItem.enabled = YES;

}

//添加自定义TextView
- (void)setUpTextView{
    
    ZTEmotionTextView *textView = [[ZTEmotionTextView alloc] initWithFrame:self.view.bounds];

    textView.contentSize = CGSizeMake(self.view.width, self.view.height - 64);
    
    _textView = textView;
    
    textView.font = [UIFont systemFontOfSize:18];
    
    textView.placeHolder = @"分享新鲜事...";
    
    [self.view addSubview:textView];
    
    // 默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
    //监听键盘弹起事件
    [ZTNotificationCenter addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //监听输入框文本输入
    [ZTNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    // 表情选中的通知
    [ZTNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:ZTEmotionDidSelectNotification object:nil];
    
    // 删除文字的通知
    [ZTNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:ZTEmotionDidDeleteNotification object:nil];
    
    _textView.delegate = self;
    
}

- (void)setUpNavgationBar{

    [self.navigationItem setTitle:@"发微博"];

    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    //right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    rightItem.enabled = NO;
    
    _rightItem = rightItem;
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
    
}

- (void)textChange{
    
//    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;

    //判断是否有内容
    if (_textView.fullText.length) {
        
        _textView.hidePlaceHolder = YES;
        
        _rightItem.enabled = YES;
        
    }else{
    
        _textView.hidePlaceHolder = NO;
        
        _rightItem.enabled = NO;
        
    }

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];

}

// 发送微博
- (void)compose{
    
    NSLog(@"发微博");
    
    if (self.images.count) {
        
        [self sendPicture];
        
    }else{
    
        [self sendTitle];
        
    }
    
}

//发送文字
- (void)sendTitle{

    [ZTComposeTool composeWithStatus:_textView.fullText success:^{
        
        [MBProgressHUD showSuccess:@"发送文字成功"];
        
        //返回首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        
        NSLog(@"发送失败");
        
    }];

}

//发送图片
- (void)sendPicture{
    
    UIImage *image = self.images[0];
    
    NSString *status = _textView.fullText.length?_textView.fullText:@"分享微博";
    
    _rightItem.enabled = NO;
    
    [ZTComposeTool composeWithStatus:status image:image success:^{
        
        [MBProgressHUD showSuccess:@"发送图片成功"];
        
        _rightItem.enabled = YES;
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showSuccess:@"发送图片失败"];
        
        _rightItem.enabled = YES;
        
    }];
    
}

- (void)dismiss{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 监听方法
/**
 *  删除文字
 */
- (void)emotionDidDelete
{
    [self.textView deleteBackward];
    
    if (_textView.fullText.length <= 0) {
        
        _textView.hidePlaceHolder = NO;
        
        _rightItem.enabled = NO;
        
    }
}

/**
 *  表情被选中了
 */
- (void)emotionDidSelect:(NSNotification *)notification
{
    _textView.hidePlaceHolder = YES;
    
    _rightItem.enabled = YES;

    ZTEmotion *emotion = notification.userInfo[ZTSelectEmotionKey];
    
    [self.textView insertEmotion:emotion];
}


/**
 *  切换键盘
 */
- (void)switchKeyboard
{
    // self.textView.inputView == nil : 使用的是系统自带的键盘
    if (self.textView.inputView == nil) { // 切换为自定义的表情键盘
        self.textView.inputView = self.emotionKeyboard;
        
        // 显示键盘按钮
        self.toolBar.showKeyboardButton = YES;
    } else { // 切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情按钮
        self.toolBar.showKeyboardButton = NO;
    }
    
    // 开始切换键盘
    self.switchingKeybaord = YES;
    
    // 退出键盘
    [self.textView endEditing:YES];
    
    // 结束切换键盘
    self.switchingKeybaord = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
    });
}

- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework，利用这个框架可以获得手机上的所有相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    //    self.picking = YES;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
