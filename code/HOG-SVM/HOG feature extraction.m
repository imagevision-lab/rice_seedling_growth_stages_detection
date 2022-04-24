clear all;  %%%%%%%��չ�������������

n=24;   %������������ɣ�nȡ11~15,21~25,31~35��

%%%%ѡ��ָ������ͼ����ļ��У�����˴�ѡ��һҶ��ͼƬ���ļ��У�����jpg��ʽ��ͼƬ�ļ�
srcDir=uigetdir('Choose source directory.');
cd(srcDir);
allnames1=struct2cell(dir('*.jpg'));    %%%allnames1����������һҶ�������ͼƬ����Ϣ


%%%%ѡ��ָ������ͼ����ļ��У�����˴�ѡ���Ҷ��ͼƬ���ļ��У�����jpg��ʽ��ͼƬ�ļ�
srcDir=uigetdir('Choose source directory.');
cd(srcDir);
allnames2=struct2cell(dir('*.jpg'));     %%%allnames2���������˶�Ҷ�������ͼƬ����Ϣ

%%%%ѡ��ָ������ͼ����ļ��У�����˴�ѡ����Ҷ��ͼƬ���ļ��У�����jpg��ʽ��ͼƬ�ļ�
srcDir=uigetdir('Choose source directory.');
cd(srcDir);
allnames3=struct2cell(dir('*.jpg'));     %%%allnames3������������Ҷ�������ͼƬ����Ϣ


[m1,n1]=size(allnames1);
for i=1:n1
    
    aa=imread(strcat(strcat(allnames1{2,i},'\'),allnames1{1,i}));    %%%%%����������ļ�·����ͬѧ�ǿ��Ծ�������������allnames1�����������ݣ�����ֱ���������д��ڴ���allnames1{:,1}
    
    %%%%%%feature11��12��13......21��22.....31��32.....�ֱ�Ϊ��ͬ�������Ե�HOG����
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
    
    %%%%%%��һҶ������ͼƬ��ȡ��HOG���������feature**_1st�������棬������SVM����ʹ��
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



%%%%%%���ƵĴ�����ȡ��Ҷ��ͼƬ��HOG����
[m2,n2]=size(allnames2);    
for i=1:n2
    aa=imread(strcat(strcat(allnames2{2,i},'\'),allnames2{1,i}));    %%%%%����������ļ�·����ͬѧ�ǿ��Ծ�������������allnames2�����������ݣ�����ֱ���������д��ڴ���allnames2{:,1}
  
    %%%%%%feature11��12��13......21��22.....31��32.....�ֱ�Ϊ��ͬ�������Ե�HOG����
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
   
    
    %%%%%%�Ѷ�Ҷ������ͼƬ��ȡ��HOG���������feature**_2nd�������棬������SVM����ʹ��
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


%%%%%%���ƵĴ�����ȡ��Ҷ��ͼƬ��HOG����
[m3,n3]=size(allnames3);    
for i=1:n3
    aa=imread(strcat(strcat(allnames3{2,i},'\'),allnames3{1,i}));    %%%%%����������ļ�·����ͬѧ�ǿ��Ծ�������������allnames2�����������ݣ�����ֱ���������д��ڴ���allnames2{:,1}
    
    %%%%%%feature11��12��13......21��22.....31��32.....�ֱ�Ϊ��ͬ�������Ե�HOG����
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
   
    
    %%%%%%����Ҷ������ͼƬ��ȡ��HOG���������feature**_3rd�������棬������SVM����ʹ��
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

%%%%���ϳ�����ȡ��ͬHOG�������


%%%%%���³��򹹽�SVM��������ѵ��������֤�����Ͳ��Լ����Բ���HOG������feature11Ϊ���ӣ�����HOG����ͬ���Ĳ���ԭ��

%%%%%������������У������ȡͼƬ����ѵ������n1ΪһҶ��ͼƬ��������n2Ϊ��Ҷ��ͼƬ��������n3Ϊ��Ҷ��ͼƬ��������

RandIndex = randperm( n1 );
x1 = feature_1st( RandIndex,: ); 

RandIndex = randperm( n2 );
x2 = feature_2nd( RandIndex,: );

RandIndex = randperm( n3 );
x3 = feature_3rd( RandIndex,: );

%%%%%%%x_trainΪѵ����,   60%��Ϊѵ����
x_train=[x1(1:floor(n1*0.6),:);x2(1:floor(n2*0.6),:);x3(1:floor(n3*0.6),:)];

[width length]=size(x_train);      %%%��ȡѵ��������������������

x_train(1:floor(n1*0.6),length+1)=1;        %%%%һҶ�����÷����ǩΪ��1��
x_train((floor(n1*0.6)+1):(floor(n1*0.6)+1+floor(n2*0.6)),length+1)=2;     %%%%��Ҷ�����÷����ǩΪ��2��
x_train(((floor(n1*0.6)+1+floor(n2*0.6))+1):end,length+1)=3;           %%%%��Ҷ�����÷����ǩΪ��3��




%%%%%����Ϊ��֤���� 20%��Ϊ��֤��
x_1st_valdtation=x1(ceil(n1*0.6):floor(n1*0.8),:);
x_2nd_valdtation=x2(ceil(n2*0.6):floor(n2*0.8),:);
x_3rd_valdtation=x3(ceil(n3*0.6):floor(n3*0.8),:);


%%%%%����Ϊ���Լ��� 20%��Ϊ���Լ�
x_1st_test=x1(ceil(n1*0.8):end,:);
x_2nd_test=x2(ceil(n2*0.8):end,:);
x_3rd_test=x3(ceil(n3*0.8):end,:);