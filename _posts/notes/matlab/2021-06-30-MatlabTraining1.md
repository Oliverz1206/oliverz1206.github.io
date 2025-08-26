---
title: MATLAB Training 1 | MATLAB 入门 1 
date: 2021-06-30 12:15:00 +0800
categories: [Notes, Matlab]
tags: [Matlab Basic]
math: true
---

## 前言
花费了五天时间学习了MATLAB，在这里只做简单的展示和自己学习的备份。如果有任何勘误或者理解、使用有误的地方，请在评论区中指出，非常感谢！
此学习版本为MATLAB 2021b。

## A. MATLAB界面
MATLAB界面可以大致分为四块：

![在这里插入图片描述](/assets/img/notes/matlab/matlab-window-layout.png){: width="550"}
_Window Baisc Layout_

其中：
**红色区域**是当前文件夹路径所包含的内容
**黄色区域**是所有打开的内容，包括文档，展开的变量，函数等
**绿色区域**是工作区，是所有缓存的数据和变量，不保存关闭MATLAB会导致变量丢失。
**蓝色区域**是命令行窗口，在此窗口下可以写MATLAB的相关指令，供MATLAB直接运行

## B. 数据的处理
### 1. 数据的导入
MATLAB支持的文件格式可以参考[MATLAB官方文档](https://ww2.mathworks.cn/help/matlab/import_export/supported-file-formats.html)。

![在这里插入图片描述](/assets/img/notes/matlab/import1.png){: width="550"}

使用图中导入数据工具可以把数据导入到工作区。例如，打开一个不同国家在不同时期的汽油价格的一张Excel表格，界面如下：

![在这里插入图片描述](/assets/img/notes/matlab/import2.png){: width="550"}

其中：

**红色区域**代表的是要导入的区域，跟Excel一样，可以用鼠标选中区域，也可以输入区域（使用 “ : ” 划定区域，使用 “ , ” 选取多个区域）
**黄色区域**是给定行标题
**蓝色区域**是选取导入的方式，其中有“表”，“数值矩阵”等方式。

选取完毕后点击导入所选内容即可完成导入。
对于.mat类型的导入，可以在左侧直接双击即可导入到工作区。也可以用以下指令完成导入：

~~~
load xxx.mat
load('xxx.mat')
~~~

对于想要导入mat中特定的变量，可以使用:

~~~
load xxx.mat Germany
load('xxx.mat','Germany')
~~~

查看所有导入的数据属性，使用：

~~~
whos
~~~

### 2. 数据的保存
工作区内的数据往往需要保存，为之后的数据处理做好准备。

**方法一**
在工作区内按住ctrl选中所需要的数据，右键选择保存。可以保存为mat类型以供后续使用。

**方法二**
使用以下指令完成导出：

~~~
save(文件名,工作区内的数据名)
save("ch2.mat",Germany)
~~~

**将数据添加进已经保存的数据中：**

**方法一**
使用以下指令完成添加：

~~~
save(文件名,变量,'-append')
save("ch2.mat",Germany,'-append')
~~~

**方法二**
在左侧选中一个mat类文件，将变量和数据直接选中拖入左下角一栏：

![在这里插入图片描述](/assets/img/notes/matlab/save.png){: width="550"}

### 3. 数据的删除
在命令行中输入：

~~~
clc  % 可以将之前的命令记录全部清除
~~~

在命令行中输入：

~~~
clear / clear all    % 清除所有工作区内的数据
clear 变量名        % 清除工作区内的指定数据
~~~

### 4. 数据的裁剪与处理
一个列表想要以可视化形式输出，需要对数据做预处理才能进行作图。一个原始的数值矩阵可以分为一个个向量以便于绘图。

双击工作区内的数据矩阵变量，以打开一个变量。

![在这里插入图片描述](/assets/img/notes/matlab/data-processing.png){: width="550"}

选中其中的一列，在左上角即可新建为一个行向量。选中区域也可以获得相应的新的数据矩阵。

当数据量比较大时，使用指令会更加方便：

~~~
E.g. 矩阵变量名为：gprice
gprice_binary = gprice(3,4) % 选中一个元素 3行4列
gprice_binary = gprice(3,:) % 选中第三行，gprice_binary 为行向量
gprice_binary = gprice(:,4) % 选中第四列，gprice_binary 为列向量
gprice_binary = gprice(4:8,9:16) % 选中4-8行，9-16列，gprice_binary 为子矩阵
gprice_binary = gprice(4:8,[1,3,5]) % 选中4-8行，1,3,5列，gprice_binary 为子矩阵
gprice_binary = gprice(:,end) % 选中最后一行
~~~

### 5 数据的创建
除了导入数据之外，还需要自己建立一些变量以供使用：

~~~
  1. 对于定义一个数值：
	 a = 3.6
  (ps: 通常MATLAB对于小数都是双精度类的，也就是精度在16位左右)
  
  2.对于定义一个字符串：
    str = "Hello World!"
    
  3. 对于定义一个向量：
    a = [3 4 5] / [3,4,5]    % 1x3 行向量
    a = [3;4;5]    % 3x1 列向量
    a = 1:2:10     % 以1为起始，<10，步长为2的的等长行向量 [1 3 5 7 9]
    a = linspace(3,6,4) % 把3到8的数4等分的行向量 [3 4 5 6]

  4. 对于定义一个矩阵：
    a = [1 2 3; 4 5 6; 7 8 9]   % 一个3x3的矩阵，由分号换行
    a = eye(5)      % 一个5x5的单位矩阵
    a = zeros(5,3)  % 一个5x3值均为0的矩阵
    a = ones(2,2)   % 一个2x2值均为1的矩阵
    a = magic(5)    % 一个 每行、每列、每条对角线上的所有数值和均相等的矩阵
    (其他函数包括：compan pascal gallery randi hadamard rosser hankel toeplitz hilb vander invhilb wilkinson magic)
    
  5. 随机数产生：
    a = randn(m,n)  % 产生一个m行n列的以正态分布产生的随机数
    a = rand(m,n)   % 产生一个m行n列的平均分布的随机数
~~~

### 6. 数据的类型
* 向量 (Vector)
* 元胞 (cell)
* 数值矩阵 (Matrix)
* 表 (Table)

## C. 实时脚本（live script）
实时脚本和脚本是命令的集合。根据MATLAB官方教学的人员解释，在2017年已经开始使用实时脚本替代原始的脚本文件。

![在这里插入图片描述](/assets/img/notes/matlab/live-script.png){: width="550"}

左侧是脚本，右侧是实时演示的结果。左侧的编辑区内通过上方的按键可以切换文本模式和代码模式。文本模式下的所有内容都不会被执行，只有在代码行中会被执行。

文本栏中有标题选项，可以撰写标题，并且可以进行加粗等操作。代码段中可以打注释等。分节符可以将代码分段，可以不让程序全部运行，以代码段的方式运行。

## D. 收藏栏
可以将常用的代码放置在收藏夹以便以后方便调用。

![在这里插入图片描述](/assets/img/notes/matlab/star.png){: width="550"}

在收藏夹一栏中，可以新建收藏项，可以将带代码保存，并且可以将其置顶。

## E. 简单的绘图 (Plot)
对于简单的线图，可以用下面这个函数来绘制图形：

~~~
plot()  %二维绘图
plot3() %三维绘图
~~~

当然，如果更全面的了解plot函数，请参考[MATLAB官方文档](https://ww2.mathworks.cn/help/matlab/ref/plot.html?lang=en)。

也有很多人已经对于这个函数做了非常详细的解读和用法的说明：[MATLAB中plot函数的用法](https://blog.csdn.net/xuxinrk/article/details/80051238)。

### 1. 绘制图形
当两个向量长度相同时，即可使用plot函数：

~~~
plot(x,y);            %笛卡尔坐标系中的绘图
polarplot(theta,rho); %极坐标系中绘图（不说明）
~~~

### 2. 添加属性
对于一个二维图像，我们需要添加标题，横纵轴描述，对于线宽、线的形状都会有一定的要求，以增加图表的可读性。

~~~
Example:
plot(Year,Germany,"Marker",".","LineStyle","--");
%Year是横坐标向量，Germany是纵坐标向量，后面的所有项目都是属性。
~~~

#### i. 线条属性
~~~
Marker          %标记形状 ['o' 圆圈; '+' 加号; '*' 星号; '.'	点; 'x' 叉号; '_' 水平线条;
                          '|' 垂直线条; 's' 方形; 'd' 菱形; '^' 上三角; 'v' 下三角; 
                          '>' 右三角; '<' 左三角; 'p' 五角星; 
                          'h'六角形; 'none'无标记]
MarkerSize      %标记大小（默认6）
MarkerEdgeColor %标记外围颜色（常规/缩写'r'/16进制rgb颜色[0.36,0.32,0.02]）
MarkerFaceColor %标记填充颜色（常规/缩写'r'/16进制rgb颜色[0.36,0.32,0.02]）
Color           %线条颜色（常规/缩写'r'/16进制rgb颜色[0.36,0.32,0.02]）
LineWidth       %线条宽度 （默认0.5）
LineStyle       %线条形状 ['-'实线; '--'虚线; ':'点线; '-.'点划线]
~~~

#### ii. 标题
具体参考[Title文档](https://ww2.mathworks.cn/help/matlab/ref/title.html?searchHighlight=title&s_tid=srchtitle_title_1)
~~~
1. title("Annual gas prices in Germany"); %可以直接添加标题

2. [t,s] = title('Straight Line','Slope = 1, y-Intercept = 0'); %可以添加副标题（t为主标题，s为副标题）其中可以对t和s分别添加属性。（t.color = 'red'）

3. title(ax1,'Top Plot')
   title(ax2,'Bottom Plot') %可以对每一个坐标区添加标题
~~~
相应可以使用的属性：
~~~
FontSize         %字体大小
FontWeight       %字体粗细（'normal' / 'bold'）
FontName         %字体
Color            %字体颜色（常规缩写'r'或者16进制rgb颜色[0.36,0.32,0.02]）
Interpreter      %解释器（默认'tex', 可以使用'latex'）
~~~

#### iii. 横纵轴属性
具体参考[xlabel&ylabel文档](https://ww2.mathworks.cn/help/matlab/ref/xlabel.html?searchHighlight=xlabel&s_tid=srchtitle_xlabel_1)。
**xlabel()和ylabel()使用方法基本一致。**

~~~
1. xlabel('-2\pi \leq x \leq 2\pi')  %直接添加标题

2. xlabel('Population','FontSize',12,'FontWeight','bold','Color','r') % 为横纵坐标添加相应属性

3. xlabel(ax1,'Population') %为单个坐标区内的坐标添加名称
~~~

%注：如果要添加特殊字符（如alpha）或者上下标：

~~~
^{ }   %大括号内的即为上标内容
_{ }   %大括号内的即为下标内容
/alpha %表示希腊字母alpha
~~~

相应可以使用的属性：

~~~
FontSize         %字体大小
FontWeight       %字体粗细（'normal' / 'bold'）
FontName         %字体
Color            %字体颜色（常规缩写'r'或者16进制rgb颜色[0.36,0.32,0.02]）
Interpreter      %解释器（默认'tex', 可以使用'latex'）
~~~

#### iv. 图例
具体参考[legend文档](https://ww2.mathworks.cn/help/matlab/ref/legend.html?searchHighlight=legend&s_tid=srchtitle_legend_1)。
对于一张图内包含有多个线条时，可以通过添加图例更大明显的显示每一根线条所表示的数据内容。

~~~
1. legend('cos(x)','cos(2x)')              %直接添加图例

2.legend(ax1,{'Line 1','Line 2','Line 3'}) %为特定图表添加图例

3. lgd = legend('cos(x)','cos(2x)');
   title(lgd,'My Legend Title')            %为图例添加标题

4. lgd = legend({'Line 1','Line 2','Line 3','Line 4'},'FontSize',12,'TextColor','blue') 
    lgd.NumColumns = 2;                    %为图例添加属性并且分多列展示
~~~

相应可以使用的属性：

~~~
Location      %图例在图中的相对位置 （east/west/southeast...）
Orientation   %图例的展示方向 （vertical / horizontal）
TextColor     %图例的文本颜色
FontSize      %图例的文本大小
NumColumns    %图例分列展示
~~~