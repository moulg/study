#remark
--[[
	windows 常用消息虚拟键码
]]

VK_LBUTTON 				= 0x01		--鼠标左键
VK_RBUTTON				= 0x02      --鼠标右键
VK_CANCEL				= 0x03      --控制中断键，就是Ctrl+Pause Break
VK_MBUTTON				= 0x04      --鼠标中键
VK_XBUTTON1				= 0x05      --鼠标X1键，具体哪个键根据实际情况而定
VK_XBUTTON2				= 0x06      --鼠标X2键，具体哪个键根据实际情况而定
VK_BACK 				= 0x08      --退格键，Backspace
VK_TAB					= 0x09      --制表键，就是Tab
VK_CLEAR				= 0x0C      --Clear键，Num Lock关闭时的数字键盘5
VK_RETURN				= 0x0D      --回车键，Enter
VK_SHIFT 				= 0x10      --上档键，就是Shift
VK_CONTROL 				= 0x11      --控制键，就是Ctrl
VK_MENU 				= 0x12      --换挡键，就是Alt
VK_PAUSE 				= 0x13      --中断暂停键，Pause Break
VK_CAPITAL 				= 0x14      --大小写锁定键，Caps Lock
VK_ESCAPE 				= 0x1B      --退出键，Esc
VK_SPACE 				= 0x20      --空格键，SpaceBar
VK_PRIOR 				= 0x21      --向上翻页键，Page Up
VK_NEXT 				= 0x22      --向下翻页键，Page Down

VK_END               	= 0x23       --结尾键，就是End
VK_HOME              	= 0x24       --起始键，就是Home

VK_LEFT              	= 0x25       --左方向键，就是←
VK_UP                	= 0x26       --上方向键，就是↑
VK_RIGHT             	= 0x27       --右方向键，就是→
VK_DOWN              	= 0x28       --下方向键，就是↓


VK_SNAPSHOT          	= 0x2C       --屏幕打印键，就是Print Screen
VK_INSERT            	= 0x2D       --插入键，就是Insert
VK_DELETE            	= 0x2E       --删除键，就是Delete

VK_0				 	= 0x30		  --数字0
VK_1				 	= 0x31		  --数字1
VK_2				 	= 0x32		  --数字2
VK_3				 	= 0x33		  --数字3
VK_4					= 0x34		  --数字4
VK_5				 	= 0x35		  --数字5
VK_6				 	= 0x36		  --数字6
VK_7				 	= 0x37		  --数字7
VK_8				 	= 0x38		  --数字8
VK_9				 	= 0x39		  --数字9

VK_A 				 	= 0x41		  --字母A
VK_B 				 	= 0x42		  --字母B
VK_C 				 	= 0x43		  --字母C
VK_D 				 	= 0x44		  --字母D
VK_E 				 	= 0x45		  --字母E
VK_F 				 	= 0x46		  --字母F
VK_G 				 	= 0x47		  --字母G
VK_H 				 	= 0x48		  --字母H
VK_I 				 	= 0x49		  --字母I
VK_J 				 	= 0x4A		  --字母J
VK_K 				 	= 0x4B		  --字母K
VK_L 				 	= 0x4C		  --字母L
VK_M 				 	= 0x4D		  --字母M
VK_N 				 	= 0x4E		  --字母N
VK_O 				 	= 0x4F		  --字母O
VK_P 				 	= 0x50		  --字母P
VK_Q 				 	= 0x51		  --字母Q
VK_R 				 	= 0x52		  --字母R
VK_S 				 	= 0x53		  --字母S
VK_T 				 	= 0x54		  --字母T
VK_U 				 	= 0x55		  --字母U
VK_V 				 	= 0x56		  --字母V
VK_W 				 	= 0x57		  --字母W
VK_X 				 	= 0x58		  --字母X
VK_Y 				 	= 0x59		  --字母Y
VK_Z 				 	= 0x5A		  --字母Z


VK_LWIN              	= 0x5B       --左windows徽标键，就是一个窗口形状的那个键
VK_RWIN              	= 0x5C       --右windows徽标键，就是一个窗口形状的那个键
VK_APPS              	= 0x5D       --应用程序键，就是按一下弹出右键菜单的那个键
VK_SLEEP             	= 0x5F       --睡眠键，就是Sleep

VK_NUMPAD0           	= 0x60       --数字键盘0键
VK_NUMPAD1           	= 0x61       --数字键盘1键
VK_NUMPAD2           	= 0x62       --数字键盘2键
VK_NUMPAD3           	= 0x63       --数字键盘3键
VK_NUMPAD4           	= 0x64       --数字键盘4键
VK_NUMPAD5           	= 0x65       --数字键盘5键
VK_NUMPAD6           	= 0x66       --数字键盘6键
VK_NUMPAD7           	= 0x67       --数字键盘7键
VK_NUMPAD8           	= 0x68       --数字键盘8键
VK_NUMPAD9           	= 0x69       --数字键盘9键
VK_MULTIPLY          	= 0x6A       --乘法键，就是数字键盘*键
VK_ADD               	= 0x6B       --加法键，就是数字键盘+键
VK_SUBTRACT          	= 0x6D       --减法键，就是数字键盘-键
VK_DECIMAL           	= 0x6E       --小数点键，就是数字键盘.键
VK_DIVIDE            	= 0x6F       --除法键，就是数字键盘/键

VK_F1                	= 0x70       --功能1键，就是F1
VK_F2                	= 0x71       --功能2键，就是F2
VK_F3                	= 0x72       --功能3键，就是F3
VK_F4                	= 0x73       --功能4键，就是F4
VK_F5                	= 0x74       --功能5键，就是F5
VK_F6                	= 0x75       --功能6键，就是F6
VK_F7                	= 0x76       --功能7键，就是F7
VK_F8                	= 0x77       --功能8键，就是F8
VK_F9                	= 0x78       --功能9键，就是F9
VK_F10               	= 0x79       --功能10键，就是F10
VK_F11               	= 0x7A       --功能11键，就是F11
VK_F12               	= 0x7B       --功能12键，就是F12
VK_F13               	= 0x7C       --功能13键，就是F13
VK_F14               	= 0x7D       --功能14键，就是F14
VK_F15               	= 0x7E       --功能15键，就是F15
VK_F16               	= 0x7F       --功能16键，就是F16
VK_F17               	= 0x80       --功能17键，就是F17
VK_F18               	= 0x81       --功能18键，就是F18
VK_F19               	= 0x82       --功能19键，就是F19
VK_F20               	= 0x83       --功能20键，就是F20
VK_F21               	= 0x84       --功能21键，就是F21
VK_F22               	= 0x85       --功能22键，就是F22
VK_F23               	= 0x86       --功能23键，就是F23
VK_F24               	= 0x87       --功能24键，就是F24


VK_NUMLOCK           	= 0x90       --数字键盘锁定键，就是Num Lock
VK_SCROLL            	= 0x91       --滚动锁定键，就是Scroll Lock


VK_LSHIFT            	= 0xA0       --左上档键，就是Shift，控制台只使用VK_SHIFT（控制台不使用）
VK_RSHIFT            	= 0xA1       --右上档键，就是Shift，控制台只使用VK_SHIFT（控制台不使用）
VK_LCONTROL          	= 0xA2       --左控制键，就是Ctrl，控制台只是用VK_CONTROL（控制台不使用）
VK_RCONTROL          	= 0xA3       --右控制键，就是Ctrl，控制台只是用VK_CONTROL（控制台不使用）
VK_LMENU             	= 0xA4       --左换挡键，就是Alt，控制台只是用VK_MENU（控制台不使用）
VK_RMENU             	= 0xA5       --右换挡键，就是Alt，控制台只是用VK_MENU（控制台不使用）


local __char_lst = {

--特殊鍵
	[VK_RETURN] = "enter",
	[VK_SPACE] 	= "space",
	[VK_ESCAPE] = "esc",
	[VK_BACK] 	= "back",
	[VK_TAB]	= "tab",
	[VK_SHIFT]  = "shift",
	[VK_CONTROL] = "ctrl",
	[VK_MENU] 	= "atl",
	[VK_CAPITAL] = "capital",
	[VK_PRIOR] 	= "page up",
	[VK_NEXT] 	= "page down",

-- 方向鍵
	[VK_LEFT] 	= "left",
	[VK_RIGHT] 	= "right",
	[VK_UP] 	= "up",
	[VK_DOWN] 	= "down",





--0 ~ 9
	[VK_0] = "0",
	[VK_1] = "1",
	[VK_2] = "2",
	[VK_3] = "3",
	[VK_4] = "4",
	[VK_5] = "5",
	[VK_6] = "6",
	[VK_7] = "7",
	[VK_8] = "8",
	[VK_9] = "9",

--A - Z
	[VK_A] = "A",
	[VK_B] = "B",
	[VK_C] = "C",
	[VK_D] = "D",
	[VK_E] = "E",
	[VK_F] = "F",
	[VK_G] = "G",
	[VK_H] = "H",
	[VK_I] = "I",
	[VK_J] = "J",
	[VK_K] = "K",
	[VK_L] = "L",
	[VK_M] = "M",
	[VK_N] = "N",
	[VK_O] = "O",
	[VK_P] = "P",
	[VK_Q] = "Q",
	[VK_R] = "R",
	[VK_S] = "S",
	[VK_T] = "T",
	[VK_U] = "U",
	[VK_V] = "V",
	[VK_W] = "W",
	[VK_X] = "X",
	[VK_Y] = "Y",
	[VK_Z] = "Z",

--功能鍵
	[VK_F1] = "f1",
	[VK_F2] = "f2",
	[VK_F3] = "f3",
	[VK_F4] = "f4",
	[VK_F5] = "f5",
	[VK_F6] = "f6",
	[VK_F7] = "f7",
	[VK_F8] = "f8",
	[VK_F9] = "f9",
	[VK_F10] = "f10",
	[VK_F11] = "f11",
	[VK_F12] = "f12",
}

function getCharByWparam(val)
	if val then return __char_lst[val] end

	return nil
end

