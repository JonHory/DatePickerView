简单易用的时间选择器

声明

`@property (nonatomic ,strong) YXDatePickerView * datePickerView;`


记得加代理方法

`YXDataPickerViewDelegate`

懒加载

```
- (YXDatePickerView *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [YXDatePickerView addToViewController:self];
        _datePickerView.delegate = self;
    }
    return _datePickerView;
}
```

使用

```
if ([self.datePickerView isHidden]) {
    [self.datePickerView show];
}else{
    [self.datePickerView hide];
}
```
