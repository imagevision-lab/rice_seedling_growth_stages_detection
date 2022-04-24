clear all;  %%%%%%%清空工作区变量数据

n=24;   %调档改这个即可（n取11~15,21~25,31~35）

%%%%选择分割后秧盘图像的文件夹，例如此处选择一叶龄图片的文件夹，读入jpg格式的图片文件
srcDir=uigetdir('Choose source directory.');
cd(srcDir);
allnames1=struct2cell(dir('*.jpg'));    %%%allnames1变量保存了一叶龄的所有图片的信息


%%%%选择分割后秧盘图像的文件夹，例如此处选择二叶龄图片的文件夹，读入jpg格式的图片文件
srcDir=uigetdir('Choose source directory.');
cd(srcDir);
allnames2=struct2cell(dir('*.jpg'));     %%%allnames2变量保存了二叶龄的所有图片的信息

%%%%选择分割后秧盘图像的文件夹，例如此处选择三叶龄图片的文件夹，读入jpg格式的图片文件
srcDir=uigetdir('Choose source directory.');
cd(srcDir);
allnames3=struct2cell(dir('*.jpg'));     %%%allnames3变量保存了三叶龄的所有图片的信息


[m1,n1]=size(allnames1);
for i=1:n1
    
    aa=imread(strcat(strcat(allnames1{2,i},'\'),allnames1{1,i}));    %%%%%构建读入的文件路径，同学们可以具体点击工作区的allnames1看看里面内容，或者直接在命令行窗口打入allnames1{:,1}
    
    %%%%%%feature11、12、13......21、22.....31、32.....分别为不同特征属性的HOG特征
    switch n
        case 11
            [feature11,hogvisualization11]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[2 2]);
        case 12
            [feature12,hogvisualization12]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[3 3]);
        case 13
            [feature13,hogvisualization13]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[4 4]);
        case 14
            [feature14,hogvisualization14]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[5 5]);
        case 15
            [feature15,hogvisualization15]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[6 6]);
    
    
        case 21
            [feature21,hogvisualization21]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[2 2]);
        case 22
            [feature22,hogvisualization22]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[3 3]);
        case 23
            [feature23,hogvisualization23]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[4 4]);
        case 24
            [feature24,hogvisualization24]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[5 5]);
        case 25
            [feature25,hogvisualization25]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[6 6]);
   
    
        case 31
            [feature31,hogvisualization31]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[2 2]);
        case 32
            [feature32,hogvisualization32]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[3 3]);
        case 33
            [feature33,hogvisualization33]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[4 4]);
        case 34
            [feature34,hogvisualization34]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[5 5]);
        case 35
            [feature35,hogvisualization35]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[6 6]);
    end
    
    %%%%%%把一叶龄所有图片提取的HOG特征存放在feature**_1st变量里面，待后续SVM分类使用
    switch n
        case 11
            feature_1st(i,:)=feature11;
        case 12
            feature_1st(i,:)=feature12;
        case 13
            feature_1st(i,:)=feature13;
        case 14
            feature_1st(i,:)=feature14;
        case 15
            feature_1st(i,:)=feature15;
    
        case 21
            feature_1st(i,:)=feature21;
        case 22
            feature_1st(i,:)=feature22;
        case 23
            feature_1st(i,:)=feature23;
        case 24
            feature_1st(i,:)=feature24;
        case 25
            feature_1st(i,:)=feature25;
    
        case 31
            feature_1st(i,:)=feature31;
        case 32
            feature_1st(i,:)=feature32;
        case 33
            feature_1st(i,:)=feature33;
        case 34
            feature_1st(i,:)=feature34;
        case 35
            feature_1st(i,:)=feature35;
    end
end



%%%%%%相似的处理，提取二叶龄图片的HOG特征
[m2,n2]=size(allnames2);    
for i=1:n2
    aa=imread(strcat(strcat(allnames2{2,i},'\'),allnames2{1,i}));    %%%%%构建读入的文件路径，同学们可以具体点击工作区的allnames2看看里面内容，或者直接在命令行窗口打入allnames2{:,1}
  
    %%%%%%feature11、12、13......21、22.....31、32.....分别为不同特征属性的HOG特征
    switch n
        case 11
            [feature11,hogvisualization11]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[2 2]);
        case 12
            [feature12,hogvisualization12]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[3 3]);
        case 13
            [feature13,hogvisualization13]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[4 4]);
        case 14
            [feature14,hogvisualization14]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[5 5]);
        case 15
            [feature15,hogvisualization15]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[6 6]);
    
    
        case 21
            [feature21,hogvisualization21]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[2 2]);
        case 22
            [feature22,hogvisualization22]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[3 3]);
        case 23
            [feature23,hogvisualization23]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[4 4]);
        case 24
            [feature24,hogvisualization24]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[5 5]);
        case 25
            [feature25,hogvisualization25]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[6 6]);
   
    
        case 31
            [feature31,hogvisualization31]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[2 2]);
        case 32
            [feature32,hogvisualization32]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[3 3]);
        case 33
            [feature33,hogvisualization33]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[4 4]);
        case 34
            [feature34,hogvisualization34]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[5 5]);
        case 35
            [feature35,hogvisualization35]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[6 6]);
    end
   
    
    %%%%%%把二叶龄所有图片提取的HOG特征存放在feature**_2nd变量里面，待后续SVM分类使用
    switch n
        case 11
            feature_2nd(i,:)=feature11;
        case 12
            feature_2nd(i,:)=feature12;
        case 13
            feature_2nd(i,:)=feature13;
        case 14
            feature_2nd(i,:)=feature14;
        case 15
            feature_2nd(i,:)=feature15;
    
        case 21
            feature_2nd(i,:)=feature21;
        case 22
            feature_2nd(i,:)=feature22;
        case 23
            feature_2nd(i,:)=feature23;
        case 24
            feature_2nd(i,:)=feature24;
        case 25
            feature_2nd(i,:)=feature25;
    
        case 31
            feature_2nd(i,:)=feature31;
        case 32
            feature_2nd(i,:)=feature32;
        case 33
            feature_2nd(i,:)=feature33;
        case 34
            feature_2nd(i,:)=feature34;
        case 35
            feature_2nd(i,:)=feature35;
    end     
end


%%%%%%相似的处理，提取三叶龄图片的HOG特征
[m3,n3]=size(allnames3);    
for i=1:n3
    aa=imread(strcat(strcat(allnames3{2,i},'\'),allnames3{1,i}));    %%%%%构建读入的文件路径，同学们可以具体点击工作区的allnames2看看里面内容，或者直接在命令行窗口打入allnames2{:,1}
    
    %%%%%%feature11、12、13......21、22.....31、32.....分别为不同特征属性的HOG特征
    switch n
        case 11
            [feature11,hogvisualization11]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[2 2]);
        case 12
            [feature12,hogvisualization12]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[3 3]);
        case 13
            [feature13,hogvisualization13]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[4 4]);
        case 14
            [feature14,hogvisualization14]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[5 5]);
        case 15
            [feature15,hogvisualization15]=extractHOGFeatures(aa,'CellSize',[8 8],'BlockSize',[6 6]);
    
    
        case 21
            [feature21,hogvisualization21]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[2 2]);
        case 22
            [feature22,hogvisualization22]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[3 3]);
        case 23
            [feature23,hogvisualization23]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[4 4]);
        case 24
            [feature24,hogvisualization24]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[5 5]);
        case 25
            [feature25,hogvisualization25]=extractHOGFeatures(aa,'CellSize',[16 16],'BlockSize',[6 6]);
   
    
        case 31
            [feature31,hogvisualization31]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[2 2]);
        case 32
            [feature32,hogvisualization32]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[3 3]);
        case 33
            [feature33,hogvisualization33]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[4 4]);
        case 34
            [feature34,hogvisualization34]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[5 5]);
        case 35
            [feature35,hogvisualization35]=extractHOGFeatures(aa,'CellSize',[32 32],'BlockSize',[6 6]);
    end
   
    
    %%%%%%把三叶龄所有图片提取的HOG特征存放在feature**_3rd变量里面，待后续SVM分类使用
    switch n
        case 11
            feature_3rd(i,:)=feature11;
        case 12
            feature_3rd(i,:)=feature12;
        case 13
            feature_3rd(i,:)=feature13;
        case 14
            feature_3rd(i,:)=feature14;
        case 15
            feature_3rd(i,:)=feature15;
    
        case 21
            feature_3rd(i,:)=feature21;
        case 22
            feature_3rd(i,:)=feature22;
        case 23
            feature_3rd(i,:)=feature23;
        case 24
            feature_3rd(i,:)=feature24;
        case 25
            feature_3rd(i,:)=feature25;
    
        case 31
            feature_3rd(i,:)=feature31;
        case 32
            feature_3rd(i,:)=feature32;
        case 33
            feature_3rd(i,:)=feature33;
        case 34
            feature_3rd(i,:)=feature34;
        case 35
            feature_3rd(i,:)=feature35;
    end     
end

%%%%以上程序提取不同HOG特征完毕


%%%%%以下程序构建SVM向量机的训练集、验证集、和测试集，以测试HOG特征的feature11为例子，其他HOG特征同样的操作原理

%%%%%建立随机数序列，随机抽取图片构建训练集，n1为一叶龄图片的数量，n2为二叶龄图片的数量，n3为三叶龄图片的数量。

RandIndex = randperm( n1 );
x1 = feature_1st( RandIndex,: ); 

RandIndex = randperm( n2 );
x2 = feature_2nd( RandIndex,: );

RandIndex = randperm( n3 );
x3 = feature_3rd( RandIndex,: );

%%%%%%%x_train为训练集,   60%作为训练集
x_train=[x1(1:floor(n1*0.6),:);x2(1:floor(n2*0.6),:);x3(1:floor(n3*0.6),:)];

[width length]=size(x_train);      %%%提取训练集的行数量和列数量

x_train(1:floor(n1*0.6),length+1)=1;        %%%%一叶龄设置分类标签为‘1’
x_train((floor(n1*0.6)+1):(floor(n1*0.6)+1+floor(n2*0.6)),length+1)=2;     %%%%二叶龄设置分类标签为‘2’
x_train(((floor(n1*0.6)+1+floor(n2*0.6))+1):end,length+1)=3;           %%%%三叶龄设置分类标签为‘3’




%%%%%以下为验证集， 20%作为验证集
x_1st_valdtation=x1(ceil(n1*0.6):floor(n1*0.8),:);
x_2nd_valdtation=x2(ceil(n2*0.6):floor(n2*0.8),:);
x_3rd_valdtation=x3(ceil(n3*0.6):floor(n3*0.8),:);


%%%%%以下为测试集， 20%作为测试集
x_1st_test=x1(ceil(n1*0.8):end,:);
x_2nd_test=x2(ceil(n2*0.8):end,:);
x_3rd_test=x3(ceil(n3*0.8):end,:);