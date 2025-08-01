# 2025-09-03-EO-summer-school

Material for the EO Summer School 2025 by OpenGeoHub

## In this workshop: scale up a machine learning model to large data

During this workshop, we will use a simple machine learning model as an example to demonstrate how to scale up an EO workflow to large data on HPC. We prepared a single use case, where a binary waterbody classification model is trained on a cutout of a Sentinel-2 RGB image. The model is then applied to the full Sentinel-2 RGB image, which is about 1.5 GB in size, predicting water and non-water pixels.

## File structures

In the `notebook` directory, we prepared two example:

- step1_train_on_cutout.ipynb: training a simple binary classifier on a RGB cutout;
- step2_prediction_on_large_data.ipynb: apply the trained model on a 1.5 GB RGB image;

Besides the examples, in `data_preparation/data_preparation.ipynb` the process of generating the example RGB image is demonstrated.

## Data

The data used in this workshop can be found on Zenodo: [link](https://zenodo.org/records/16613694).
