# rice_seedling_growth_stages_detection

This repository contains the code and results in context of the paper titled **Machine Learning Approaches for Rice Seedling Growth Stages Detection**

### Organisation of code

The code for all the experiment configurations is arranged in directory structures across two different levels.

The first layer is divided into a selection based on HOG-SVM and Deep Learning networks, which is divided into :

- Deep Learning

- HOG-SVM

In each folder, the second layer is based on the choice of different networks.

Example configuration file name: `effb4_380_2000.ipynb`
- `effb4` is using EfficientB4 network
- `380` is using dataset size
- `2000` is using 2000 images for each type of data, dataset total 2000 x 3 = 6000 images.

The following files are:

- `vgg16_224.ipynb`
- `res50_224.ipynb`
- `des121_224.ipynb`
- `effb0_224.ipynb`
- `effb1_240.ipynb`
- `effb2_260.ipynb`
- `effb3_300.ipynb`
- `effb4_380.ipynb`
- `effb4_380_1000.ipynb`
- `effb4_380_2000.ipynb`
- `effb4_380_3000.ipynb`
- `effb5_456.ipynb`
- `effb6_528.ipynb`
- `effb7_600.ipynb`

### Data pre-processing

Each experiment configuration directory, containing the following files.

- `Image preprocessing.py`: Crop the original dataset, different sizes result in different datasets. The smaller the size the larger the dataset, and conversely, the larger the size the smaller the dataset

### Training

Use the `.ipynb` file to visualize the python run process, download the relevant dataset and select a model to run directly.

### Dataset Download Address

The dataset is saved on google drive and contains 224×224, 300×300, 400×400, 600×600 datasets of different sizes.

https://drive.google.com/drive/folders/1AY-ro3HID9nodrk2aIcTmGgjCzTggkks?usp=sharing
