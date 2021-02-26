import matplotlib.pyplot as plt
from keras_segmentation.models.unet import vgg_unet

model = vgg_unet(n_classes=51,  input_height=416, input_width=608)

model.train(
    train_images="/data/dataset1/images_prepped_train/",
    train_annotations="/data/dataset1/annotations_prepped_train/",
    checkpoints_path="/tmp/vgg_unet_1", epochs=5
)

out = model.predict_segmentation(
    inp="/data/dataset1/images_prepped_test/0016E5_07965.png",
    out_fname="out.png"
)

# plt.imshow(out)

# evaluating the model
print(model.evaluate_segmentation(inp_images_dir="/data/dataset1/images_prepped_test/",
                                  annotations_dir="/data/dataset1/annotations_prepped_test/"))
