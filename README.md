## Disclaimer
This is the official repo of paper [_DOTA: A Large-scale Dataset for Object Detection in Aerial Images_](https://arxiv.org/abs/1711.10398). This repo contains code for training Faster R-CNN on oriented bounding boxes and horizontal bounding boxes as reported in our paper.

This code is mostly modified by [Zhen Zhu](https://github.com/jessemelpolio) and [Jian Ding](https://github.com/dingjiansw101).

If you use these code in your project, please contain this repo in your paper or license. Please also cite our paper:

DOTA: A Large-scale Dataset for Object Detection in Aerial Images  
Gui-Song Xia\*, Xiang Bai\*, Jian Ding, Zhen Zhu, Serge Belongie, Jiebo Luo, Mihai Datcu, Marcello Pelillo, Liangpei Zhang  
In CVPR 2018. (* equal contributions)

The code is built upon a fork of [Deformble Convolutional Networks](https://github.com/msracver/Deformable-ConvNets).
We use the Faster-RCNN part of it and make some modifications based on Faster-RCNN to regress a quadrangle. More details can be seen in our [paper](https://arxiv.org/abs/1711.10398).
Note that in order to achieve better results, we adjusted the order of the quadrilateral points in the annotations during training.
. You can refer to  in DOTA\_devkit  [get_best_begin_point](https://github.com/CAPTAIN-WHU/DOTA_devkit/blob/master/dota_utils.py).

## Installation

This fork of the code has been modified to make installation on UCF ARCC clusters easier, so the scripts and these instructions will only work there.  If you are not using this on an ARCC cluster, please see the original upstream repo. Currently, this must be run on 
the Newton cluster.

1. Make sure you have the anaconda2 module loaded.  At the time of this writing, this would be achieved by running `module load anaconda/anaconda2-5.3.0`. You should *not* have a CUDA module loaded. `module unload cuda`.

2. Activate the 'deeplearning-gpu' environment `source activate deeplearning-gpu`

3. Clone this repository and `cd` into it.

4. Run `./setup-newton.sh`. this script will launch a job on a GPU node and build the code.  This only needs to be run once.


## Demo & Deformable Model

We provide trained convnet models, including Faster R-CNN models trained on DOTA.

1. To use the demo with our pre-trained faster-rcnn models for DOTA, please download manually from [Google Drive](https://drive.google.com/open?id=1b6P-UMaBBpMPlcgvc38dMToPAa_Gyu6F), or [BaiduYun](https://pan.baidu.com/s/1YuB5ib7O-Ori1ZpiGf8Egw) and put it under the following folder.

	Make sure it look like this:
	```
    ./output/rcnn/DOTA_quadrangle/DOTA_quadrangle/train/rcnn_DOTA_quadrangle-0059.params
	./output/rcnn/DOTA/DOTA/train/rcnn_DOTA_aligned-0032.params
	```

(Note) We also released the .state files recently. You can download them from [Google Drive](https://drive.google.com/open?id=1b6P-UMaBBpMPlcgvc38dMToPAa_Gyu6F), or [BaiduYun](https://pan.baidu.com/s/1YuB5ib7O-Ori1ZpiGf8Egw) and keep on fine-tuning our well-trained models on DOTA. 

## Preparation for Training & Testing

<!-- For R-FCN/Faster R-CNN\: -->

1. Please download [DOTA](https://captain-whu.github.io/DOTA/dataset.html) dataset, use the [DOTA_devkit](https://github.com/CAPTAIN-WHU/DOTA_devkit) to split the data into patches. And make sure the split images look like this:
```
./path-to-dota-split/images
./path-to-dota-split/labelTxt
./path-to-dota-split/test.txt
./path-to-dota-split/train.txt
```
The test.txt and train.txt are name of the subimages(without suffix) for train and test respectively.


2. Please download ImageNet-pretrained ResNet-v1-101 model manually from [OneDrive](https://1drv.ms/u/s!Am-5JzdW2XHzhqMEtxf1Ciym8uZ8sg), or [BaiduYun](https://pan.baidu.com/s/1YuB5ib7O-Ori1ZpiGf8Egw#list/path=%2F), or [Google drive](https://drive.google.com/open?id=1b6P-UMaBBpMPlcgvc38dMToPAa_Gyu6F), and put it under folder `./model`. Make sure it look like this:
	```
	./model/pretrained_model/resnet_v1_101-0000.params
	```

## Usage

1. All of our experiment settings (GPU #, dataset, etc.) are kept in yaml config files at folder  `./experiments/faster_rcnn/cfgs`.

2. Set the "dataset_path" and "root_path" in DOTA.yaml and DOTA_quadrangle.yaml. The "dataset_path" should be the father folder of "images" and "labelTxt". The "root_path" is the path you want to save the cache data.

3. Set the scales and aspect ratios as your wish in DOTA.yaml and DOTA_quadrangle.yaml.

3. To conduct experiments, run the python scripts with the corresponding config file as input. For example, train and test on quadrangle in an end-to-end manner, run
    ```
	python experiments/faster_rcnn/rcnn_dota_quadrangle_e2e.py --cfg experiments/faster_rcnn/cfgs/DOTA_quadrangle.yaml
    ```
    <!-- A cache folder would be created automatically to save the model and the log under `output/rfcn_dcn_coco/`. -->
4. Please find more details in config files and in our code.

## Misc.

Code has been tested under:
<!-- 
- Ubuntu 14.04 with a Maxwell Titan X GPU and Intel Xeon CPU E5-2620 v2 @ 2.10GHz -->
- Ubuntu 14.04 with 4 Pascal Titan X GPUs and 32  Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz
<!-- - Windows Server 2012 R2 with 8 K40 GPUs and Intel Xeon CPU E5-2650 v2 @ 2.60GHz
- Windows Server 2012 R2 with 4 Pascal Titan X GPUs and Intel Xeon CPU E5-2650 v4 @ 2.30GHz -->

## Cite

If you use our project, please cite:
```
@InProceedings{Xia_2018_CVPR,
author = {Xia, Gui-Song and Bai, Xiang and Ding, Jian and Zhu, Zhen and Belongie, Serge and Luo, Jiebo and Datcu, Mihai and Pelillo, Marcello and Zhang, Liangpei},
title = {DOTA: A Large-Scale Dataset for Object Detection in Aerial Images},
booktitle = {The IEEE Conference on Computer Vision and Pattern Recognition (CVPR)},
month = {June},
year = {2018}
}
```

