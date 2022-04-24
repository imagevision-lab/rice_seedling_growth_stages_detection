yfit1 = trainedModel.predictFcn(x_1st_valdtation);%SVM训练后导出的模型命名为trainedModel

count11=0;
count12=0;
count13=0;
[z1,c1]=size(x_1st_valdtation);
for i=1:z1
    if (yfit1(i)==1)    
        count11=count11+1;
    else
        if (yfit1(i)==2)
            count12=count12+1;
        else            
            if (yfit1(i)==3)
                count13=count13+1;
            end
        end
    end
end

yfit2 = trainedModel.predictFcn(x_2nd_valdtation);
count21=0;
count22=0;
count23=0;
[z2,c2]=size(x_2nd_valdtation);
for i=1:z2
    if (yfit2(i)==1)    
        count21=count21+1;
    else
        if (yfit2(i)==2)
            count22=count22+1;
        else            
            if (yfit2(i)==3)
                count23=count23+1;
            end
        end
    end
end



yfit3 = trainedModel.predictFcn(x_3rd_valdtation);
count31=0;
count32=0;
count33=0;
[z3,c3]=size(x_3rd_valdtation);
for i=1:z3
    if (yfit3(i)==1)    
        count31=count31+1;
    else
        if (yfit3(i)==2)
            count32=count32+1;
        else            
            if (yfit3(i)==3)
                count33=count33+1;
            end
        end
    end
end


a(1,1)=count11;
a(1,2)=count12;
a(1,3)=count13;
a(2,1)=count21;
a(2,2)=count22;
a(2,3)=count23;
a(3,1)=count31;
a(3,2)=count32;
a(3,3)=count33;

%%%%%%%%%test set

yfit1 = trainedModel.predictFcn(x_1st_test);

count11=0;
count12=0;
count13=0;
[z4,c4]=size(x_1st_test);
for i=1:z4
    if (yfit1(i)==1)    
        count11=count11+1;
    else
        if (yfit1(i)==2)
            count12=count12+1;
        else            
            if (yfit1(i)==3)
                count13=count13+1;
            end
        end
    end
end

yfit2 = trainedModel.predictFcn(x_2nd_test);
count21=0;
count22=0;
count23=0;
[z5,c5]=size(x_2nd_test);
for i=1:z5
    if (yfit2(i)==1)    
        count21=count21+1;
    else
        if (yfit2(i)==2)
            count22=count22+1;
        else            
            if (yfit2(i)==3)
                count23=count23+1;
            end
        end
    end
end



yfit3 = trainedModel.predictFcn(x_3rd_test);
count31=0;
count32=0;
count33=0;
[z6,c6]=size(x_3rd_test);
for i=1:z6
    if (yfit3(i)==1)    
        count31=count31+1;
    else
        if (yfit3(i)==2)
            count32=count32+1;
        else            
            if (yfit3(i)==3)
                count33=count33+1;
            end
        end
    end
end

b(1,1)=count11;
b(1,2)=count12;
b(1,3)=count13;
b(2,1)=count21;
b(2,2)=count22;
b(2,3)=count23;
b(3,1)=count31;
b(3,2)=count32;
b(3,3)=count33;