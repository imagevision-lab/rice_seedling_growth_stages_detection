import cv2
import numpy as np
import os
import shutil
from PIL import Image # 导入图像处理函数库
from PIL import ImageTk
import tkinter as tk
from tkinter import filedialog   #导入文件对话框函数库

# 创建窗口 设定大小并命名
window = tk.Tk()
window.title('图像预处理')
window.geometry('600x500')
global img_png           # 定义全局变量 图像的
var = tk.StringVar()    # 这时文字变量储存器
theLabel=tk.Label(window,text=
"需新建1个文件夹，命名为1,存放待处理图片\n"+
"其中文件夹‘Label region'中储存分割后图像、'Interference Terms'中为干扰项、'Data Sets'中为数据集\n"+
"处理时请依次点击图像分割、图像剪裁、剔除干扰项\n"+
"重复点击会覆盖之前数据")#说明语句
theLabel.pack()

def resize(w, h, w_box, h_box, pil_image):  
  f1 = 1.0*w_box/w # 1.0 forces float division in Python2  
  f2 = 1.0*h_box/h  
  factor = min([f1, f2])  
  #print(f1, f2, factor) # test  
  # use best down-sizing filter  
  width = int(w*factor)  
  height = int(h*factor)  
  return pil_image.resize((width, height), Image.ANTIALIAS) 

#创建文件夹 
def mkdir(path):
        folder = os.path.exists(path)
        if not folder:                   #判断是否存在文件夹如果不存在则创建为文件夹
                os.makedirs(path)        #makedirs 创建文件时如果路径不存在会创建这个路径
                var.set("成功创建"+path)
        else:
                var.set("已存在"+path)

#创建文件夹Data Sets,Label region,Interference Terms功能
def creat_Img():
        file = "Data Sets"#创建路径
        mkdir(file)#调用函数
        file = "Label region"
        mkdir(file)
        file = "Interference Terms"
        mkdir(file)
#创建图像分割功能
def region_Img():
    global img_png
    walk()
    w_box = 500
    h_box = 500
    Img = Image.open(r"Label region/"+"1n.jpg")
    w, h = Img.size
    img_png=ImageTk.PhotoImage(Img)
    pil_image_resized = resize(w, h, w_box, h_box, Img)
    img_png = ImageTk.PhotoImage(pil_image_resized)
    window1 = tk.Toplevel()
    window1.geometry('600x500')
    label_Img = tk.Label(window1, image=img_png,width=w_box, height=h_box)  
    label_Img.pack()
    theLabel1=tk.Label(window1,text="分割后部分结果显示如上")
    theLabel1.place(x=220,y=400)
    var.set('已分割')
    ########图像分割
def get_image(path):
    #获取图片
    img=cv2.imread(path)
    gray=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        
    return img, gray
        
def Gaussian_Blur(gray):
    # 高斯去噪
    blurred = cv2.GaussianBlur(gray, (9, 9),0)
        
    return blurred
    
def Sobel_gradient(blurred):
    # 索比尔算子来计算x、y方向梯度
    gradX = cv2.Sobel(blurred, ddepth=cv2.CV_32F, dx=1, dy=0)
    gradY = cv2.Sobel(blurred, ddepth=cv2.CV_32F, dx=0, dy=1)
        
    gradient = cv2.subtract(gradX, gradY)
    gradient = cv2.convertScaleAbs(gradient)
        
    return gradX, gradY, gradient

def Thresh_and_blur(gradient):
        
    blurred = cv2.GaussianBlur(gradient, (9, 9),0)
    (_, thresh) = cv2.threshold(blurred, 90, 255, cv2.THRESH_BINARY)
        
    return thresh
        
def image_morphology(thresh):
    # 建立一个椭圆核函数
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (25, 25))
    # 执行图像形态学
    closed = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
    closed = cv2.erode(closed, None, iterations=4)
    closed = cv2.dilate(closed, None, iterations=4)
        
    return closed
        
def findcnts_and_box_point(closed):
    # 这里opencv3返回的是三个参数
    (cnts, _) = cv2.findContours(closed.copy(), 
        cv2.RETR_LIST, 
        cv2.CHAIN_APPROX_SIMPLE)
    c = sorted(cnts, key=cv2.contourArea, reverse=True)[0]
    # compute the rotated bounding box of the largest contour
    rect = cv2.minAreaRect(c)
    box = np.int0(cv2.boxPoints(rect))
        
    return box

def drawcnts_and_cut(original_img, box):
    # draw a bounding box arounded the detected barcode and display the image
    draw_img = cv2.drawContours(original_img.copy(), [box], -1, (0, 0, 255), 3)
        
    Xs = [i[0] for i in box]
    Ys = [i[1] for i in box]
    x1 = min(Xs)
    x2 = max(Xs)
    y1 = min(Ys)
    y2 = max(Ys)
    hight = y2 - y1
    width = x2 - x1
    crop_img = original_img[y1:y1+hight, x1:x1+width]
        
    return draw_img, crop_img
        
def walk():
#重命名图片
    path = '1/'
    count = 1
    for file in os.listdir(path):
        os.rename(os.path.join(path,file),os.path.join(path,str(count)+"n.jpg"))
        count+=1
    
    a=1
    b=1
    path = '1/'  #图片存放文件夹
    cont=(len([lists for lists in os.listdir(path) if os.path.isfile(os.path.join(path, lists))]))
    #获取文件夹中所有图片数量
    while a<=cont:
        img_path = r'1/'+str(a)+'n.jpg'#读取文件夹"4"中图片
        save_path = r'Label region/'+str(b)+'n.jpg'#分割后图片保存至文件夹"Label region"中
        original_img, gray = get_image(img_path)
        blurred = Gaussian_Blur(gray)
        gradX, gradY, gradient = Sobel_gradient(blurred)
        thresh = Thresh_and_blur(gradient)
        closed = image_morphology(thresh)
        box = findcnts_and_box_point(closed)
        draw_img, crop_img = drawcnts_and_cut(original_img,box)
        
        # 显示
       
        cv2.waitKey(0)
        cv2.imwrite(save_path, crop_img)
        a+=1
        b+=1
            
def printInfo(accountE1,accountE2):
        p1 = accountE1.get()
        p2 = accountE2.get()
        return p1,p2
# 创建剪裁图像函数
def crop_Img():
        global img_png
        def printInfo():
                a2 = accountE1.get()
                a1 = accountE2.get()
                window3.destroy()
                p1=int(a1)
                p2=int(a2)
                path = 'Label region/'  #图片存放文件夹
                con=(len([lists for lists in os.listdir(path) if os.path.isfile(os.path.join(path, lists))]))
                #获取文件夹中所有图片数量
                k=1
                n=1
                while k<=con:
                    x=0
                    y=0
                    p=224           #定义剪裁图片的大小
                    u=p1
                    t=p2
                    img = cv2.imread('Label region/'+str(k)+'n.jpg')  #读取文件夹“3”中所有图片
                    size=img.shape
                    a=size[0]
                    b=size[1]
                    while (t<b):
                        while (u<a):
                            img1=img[x:u,y:t]
                            u=u+p1
                            x=x+p1
                            cv2.imwrite('Data Sets/'+str(n)+'n.jpg',img1)#保存剪裁后图片至文件夹“1”
                            n+=1
                        y=y+p2
                        t=t+p2
                        u=p1
                        x=0
                    k+=1
                    cv2.waitKey(0)
                    cv2.destroyAllWindows()   #cv2.destroyWindow(wname)
                var.set('已剪裁')
        window3 = tk.Tk()
        window3.geometry('160x70')
        accountL1 = tk.Label(window3, text="pixels=")  # pixels标签
        accountL1.place(x=2,y=3)
        accountE1 = tk.Entry(window3,width=5)
        accountE2 = tk.Entry(window3,width=5)
        #accountE.insert(0, "Kevin")
        accountE1.place(x=50,y=3)
        accountE2.place(x=110,y=3)
        accountL2 = tk.Label(window3, text="×")
        accountL2.place(x=92,y=3)
        #p1=accountE1.get()
        #p2=accountE2.get()
        loginBtn = tk.Button(window3, text="确定", width=5, height=1,command= printInfo)
        loginBtn.place(x=30,y=30)
        quitBtn = tk.Button(window3, text="取消", width=5, height=1,command=window3.destroy)
        quitBtn.place(x=90,y=30)
    
# 创建剔除干扰项函数    
def remove_Img():
    global img_png
    global img_png1
    global img_png2
    global img_png3
    global img_png4
    p=1
    path = 'Data Sets/'
    num=(len([lists for lists in os.listdir(path) if os.path.isfile(os.path.join(path, lists))]))
    #获取文件夹中所有图片数量
    while p<=num:
        path = 'Data Sets/'+str(p)+'n.jpg'
        img1 = Image.open('Data Sets/'+str(p)+'n.jpg')#读取剪裁后的图片
        img2=img1.convert('RGB')   #8位图片转换成24位图片
        width = img2.size[0]#长度
        height = img2.size[1]#宽度
        ii2=1
        jj2=1
        for i in range(0,width):#遍历所有长度的点
            for j in range(0,height):#遍历所有宽度的点
                data = (img2.getpixel((i,j)))#打印该图片的所有点
                dd1=data[0]
                dd2=data[1]
                dd3=data[2]
                ii2+=1
                if (115>=dd1>=0 and 255>=dd2>=60 and 115>=dd3>=0):  #绿色的区域取值，根据不同需求，这里的数值可以变化，主要用于设置色彩范围
                    data2 = (img2.getpixel((i,j)))
                    jj2+=1
        img2 = img2.convert("RGB")#把图片强制转成RGB
        red_data2 = jj2/ii2   

        if red_data2>0.005:
            red_data_ok2 = red_data2
        else:
            red_data_ok2 = 0
            
        if red_data_ok2 < 0.5:    #绿色占比小于50%剔除
            if os.path.exists(path):  # 如果文件存在
                shutil.move(path, 'Interference Terms/'+str(p)+'n.jpg')  #干扰项放在文件夹“Interference Terms”
            else:
                print('no such file:%s'%my_file)  # 则返回文件不存在
        p+=1
        #print("绿色占比",red_data_ok2)

    ######重命名归一化图片
    path = 'Data Sets/'
    count = 1
    for file in os.listdir(path):
        os.rename(os.path.join(path,file),os.path.join(path,str(count)+".jpg"))
        count+=1

    ######重命名干扰项图片
    path = 'Interference Terms/'
    count = 1
    for file in os.listdir(path):
        os.rename(os.path.join(path,file),os.path.join(path,str(count)+".jpg"))
        count+=1
    w_box = 100
    h_box = 100
    Img1 = Image.open(r"Data Sets/"+"1.jpg")
    Img2 = Image.open(r"Data Sets/"+"2.jpg")
    Img3 = Image.open(r"Interference Terms/"+"1.jpg")
    Img4 = Image.open(r"Interference Terms/"+"2.jpg")
    w, h = Img1.size
    pil_image_resized1 = resize(w, h, w_box, h_box, Img1)
    pil_image_resized2 = resize(w, h, w_box, h_box, Img2)
    pil_image_resized3 = resize(w, h, w_box, h_box, Img3)
    pil_image_resized4 = resize(w, h, w_box, h_box, Img4)
    img_png1 = ImageTk.PhotoImage(pil_image_resized1)
    img_png2 = ImageTk.PhotoImage(pil_image_resized2)
    img_png3 = ImageTk.PhotoImage(pil_image_resized3)
    img_png4 = ImageTk.PhotoImage(pil_image_resized4)
    window2 = tk.Toplevel()
    window2.geometry('600x500')
    label_Img1 = tk.Label(window2, image=img_png1,width=w_box, height=h_box)
    label_Img2 = tk.Label(window2, image=img_png2,width=w_box, height=h_box)
    label_Img3 = tk.Label(window2, image=img_png3,width=w_box, height=h_box)
    label_Img4 = tk.Label(window2, image=img_png4,width=w_box, height=h_box)
    label_Img1.place(x=150,y=100)
    label_Img2.place(x=300,y=100)
    label_Img3.place(x=150,y=300)
    label_Img4.place(x=300,y=300)
    theLabel2=tk.Label(window2,text="数据集部分结果显示如上")
    theLabel3=tk.Label(window2,text="干扰项部分结果显示如上")
    theLabel2.place(x=220,y=210)
    theLabel3.place(x=220,y=410)
    var.set('已剔除')   # 设置标签的文字为 '已剔除'


    

# 创建文本窗口，显示当前操作状态
Label_Show = tk.Label(window,
    textvariable=var,   # 使用 textvariable 替换 text, 因为这个可以变化
    bg='white', font=('Arial', 12), width=20, height=2)
Label_Show.pack()

#创建新建文件夹按钮
btn_creat = tk.Button(window,
    text='新建文件夹',      # 显示在按钮上的文字
    width=15, height=2,
    command=creat_Img)     # 点击按钮式执行的命令
btn_creat.place(x=30,y=130)
#创建图像分割按钮
btn_region = tk.Button(window,
    text='图像分割',      # 显示在按钮上的文字
    width=15, height=2,
    command=region_Img)     # 点击按钮式执行的命令
btn_region.place(x=170,y=130)
# 创建剪裁图像按钮
btn_crop = tk.Button(window,
    text='剪裁图像',      # 显示在按钮上的文字
    width=15, height=2,
    command=crop_Img,)     # 点击按钮式执行的命令
btn_crop.place(x=310,y=130)    # 按钮位置
# 创建剔除干扰项按钮
btn_remove = tk.Button(window,
    text='剔除干扰项',      # 显示在按钮上的文字
    width=15, height=2,
    command=remove_Img)     # 点击按钮式执行的命令
btn_remove.place(x=450,y=130)    # 按钮位置


# 运行整体窗口
window.mainloop()
