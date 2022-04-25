import cv2
import numpy as np
import os
import shutil
from PIL import Image # Import the image processing library
from PIL import ImageTk
import tkinter as tk
from tkinter import filedialog   #Import File Dialog Library

# Create a window Set the size and name it
window = tk.Tk()
window.title('Image preprocessing')
window.geometry('600x500')
global img_png          
var = tk.StringVar()   
theLabel=tk.Label(window,text=
"You need to create a new folder, named 1, to store the pictures to be processed\n"+
"Its Chinese folder 'Label region' stores the segmented image, 'Interference Terms' for interference, and 'Data Sets' for datasets\n"+
"While processing, click Segmentation, Cropping, and Culling \n"+
"Repeated clicks overwrite previous data")#Describe the statement
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

#Create a folder 
def mkdir(path):
        folder = os.path.exists(path)
        if not folder:                   #Determine if a folder exists and if it does not exist, it is created as a folder
                os.makedirs(path)        #makedirs This path is created when the file is created if it does not exist
                var.set("Successfully created"+path)
        else:
                var.set("Already exists"+path)

#Create folders for Data Sets, Label region, Interference Terms feature
def creat_Img():
        file = "Data Sets"
        mkdir(file)
        file = "Label region"
        mkdir(file)
        file = "Interference Terms"
        mkdir(file)
#Create an image segmentation function
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
    theLabel1=tk.Label(window1,text="After the split, the partial result is displayed as above")
    theLabel1.place(x=220,y=400)
    var.set('Split')
    ########Image segmentation
def get_image(path):
    #Gets the picture
    img=cv2.imread(path)
    gray=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        
    return img, gray
        
def Gaussian_Blur(gray):
 
    blurred = cv2.GaussianBlur(gray, (9, 9),0)
        
    return blurred
    
def Sobel_gradient(blurred):
 
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
   
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (25, 25))
  
    closed = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
    closed = cv2.erode(closed, None, iterations=4)
    closed = cv2.dilate(closed, None, iterations=4)
        
    return closed
        
def findcnts_and_box_point(closed):
  
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

    path = '1/'
    count = 1
    for file in os.listdir(path):
        os.rename(os.path.join(path,file),os.path.join(path,str(count)+"n.jpg"))
        count+=1
    
    a=1
    b=1
    path = '1/' 
    cont=(len([lists for lists in os.listdir(path) if os.path.isfile(os.path.join(path, lists))]))
   
    while a<=cont:
        img_path = r'1/'+str(a)+'n.jpg'
        save_path = r'Label region/'+str(b)+'n.jpg'#After splitting, the image is saved to the folder "Label region"
        original_img, gray = get_image(img_path)
        blurred = Gaussian_Blur(gray)
        gradX, gradY, gradient = Sobel_gradient(blurred)
        thresh = Thresh_and_blur(gradient)
        closed = image_morphology(thresh)
        box = findcnts_and_box_point(closed)
        draw_img, crop_img = drawcnts_and_cut(original_img,box)
        
        # display
       
        cv2.waitKey(0)
        cv2.imwrite(save_path, crop_img)
        a+=1
        b+=1
            
def printInfo(accountE1,accountE2):
        p1 = accountE1.get()
        p2 = accountE2.get()
        return p1,p2
# Creates a Crop Image function
def crop_Img():
        global img_png
        def printInfo():
                a2 = accountE1.get()
                a1 = accountE2.get()
                window3.destroy()
                p1=int(a1)
                p2=int(a2)
                path = 'Label region/'  
                con=(len([lists for lists in os.listdir(path) if os.path.isfile(os.path.join(path, lists))]))
                
                k=1
                n=1
                while k<=con:
                    x=0
                    y=0
                    p=224           
                    u=p1
                    t=p2
                    img = cv2.imread('Label region/'+str(k)+'n.jpg')  
                    size=img.shape
                    a=size[0]
                    b=size[1]
                    while (t<b):
                        while (u<a):
                            img1=img[x:u,y:t]
                            u=u+p1
                            x=x+p1
                            cv2.imwrite('Data Sets/'+str(n)+'n.jpg',img1)#Save the cropped picture to folder "1"
                            n+=1
                        y=y+p2
                        t=t+p2
                        u=p1
                        x=0
                    k+=1
                    cv2.waitKey(0)
                    cv2.destroyAllWindows()   #cv2.destroyWindow(wname)
                var.set('Cropped')
        window3 = tk.Tk()
        window3.geometry('160x70')
        accountL1 = tk.Label(window3, text="pixels=")  # pixels
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
        loginBtn = tk.Button(window3, text="OK", width=5, height=1,command= printInfo)
        loginBtn.place(x=30,y=30)
        quitBtn = tk.Button(window3, text="exit", width=5, height=1,command=window3.destroy)
        quitBtn.place(x=90,y=30)
    
# Create a knockout function    
def remove_Img():
    global img_png
    global img_png1
    global img_png2
    global img_png3
    global img_png4
    p=1
    path = 'Data Sets/'
    num=(len([lists for lists in os.listdir(path) if os.path.isfile(os.path.join(path, lists))]))
    
    while p<=num:
        path = 'Data Sets/'+str(p)+'n.jpg'
        img1 = Image.open('Data Sets/'+str(p)+'n.jpg')
        img2=img1.convert('RGB')   
        width = img2.size[0]
        height = img2.size[1]
        ii2=1
        jj2=1
        for i in range(0,width):
            for j in range(0,height):
                data = (img2.getpixel((i,j)))
                dd1=data[0]
                dd2=data[1]
                dd3=data[2]
                ii2+=1
                if (115>=dd1>=0 and 255>=dd2>=60 and 115>=dd3>=0):  
                    data2 = (img2.getpixel((i,j)))
                    jj2+=1
        img2 = img2.convert("RGB")
        red_data2 = jj2/ii2   

        if red_data2>0.005:
            red_data_ok2 = red_data2
        else:
            red_data_ok2 = 0
            
        if red_data_ok2 < 0.5:    #Green is less than 50% culling
            if os.path.exists(path): 
                shutil.move(path, 'Interference Terms/'+str(p)+'n.jpg')  #Interference items are placed in the folder "Interference Terms"
            else:
                print('no such file:%s'%my_file)  
        p+=1
        #print("green",red_data_ok2)

    ######Rename the normalized picture
    path = 'Data Sets/'
    count = 1
    for file in os.listdir(path):
        os.rename(os.path.join(path,file),os.path.join(path,str(count)+".jpg"))
        count+=1

    ######Rename the distractor picture
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
    theLabel2=tk.Label(window2,text="The dataset section results are shown above")
    theLabel3=tk.Label(window2,text="The results of the interference section are shown above")
    theLabel2.place(x=220,y=210)
    theLabel3.place(x=220,y=410)
    var.set('Culled')   


    


Label_Show = tk.Label(window,
    textvariable=var,  
    bg='white', font=('Arial', 12), width=20, height=2)
Label_Show.pack()


btn_creat = tk.Button(window,
    text='Create a folder',      
    width=15, height=2,
    command=creat_Img)     
btn_creat.place(x=30,y=130)

btn_region = tk.Button(window,
    text='Segmentation',      
    width=15, height=2,
    command=region_Img)     
btn_region.place(x=170,y=130)

btn_crop = tk.Button(window,
    text='Crop',      
    width=15, height=2,
    command=crop_Img,)     
btn_crop.place(x=310,y=130)    

btn_remove = tk.Button(window,
    text='Culling',      
    width=15, height=2,
    command=remove_Img)     
btn_remove.place(x=450,y=130)    


# Run the overall window
window.mainloop()
