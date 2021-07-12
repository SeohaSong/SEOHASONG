import os
import sys

import numpy as np
import tensorflow as tf


__question__ = '''
================================================================================
What is the proper loss-metric to fit on a target which is consist of multiple classes?
This script demonstrate the best metric is 'BinaryCrossentropy', and let's think about the reason.
================================================================================
'''


_args = {"optimizer": None, "loss": None, "metrics": []}

_feats = np.array([
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
], dtype=np.float32)

_reals = np.array([
    [0, 0, 1],
    [1, 0, 1],
    [0, 1, 0],
    [1, 0, 0]
], dtype=np.float32)

_preds1 = np.array([
    [0, 0, 1],
    [1, 0, 0],
    [0, 1, 0],
    [1, 0, 0]
], dtype=np.float32)

_preds2 = np.array([
    [0, 0, 1],
    [0, 0, 1],
    [0, 1, 0],
    [1, 0, 0]
], dtype=np.float32)

_preds3 = np.array([
    [0, 0, 1],
    [1, 0, 1],
    [0, 1, 0],
    [1, 0, 0]
], dtype=np.float32)

_Precision = tf.metrics.Precision()
_Recall = tf.metrics.Recall()


def getModel(args):
    inputs = tf.keras.Input(shape=(4))
    dense = tf.keras.layers.Dense(4)(inputs)
    outputs = tf.keras.layers.Dense(3, activation=tf.nn.sigmoid)(dense)
    model = tf.keras.Model(inputs=inputs, outputs=outputs)
    model.summary()
    model.compile(**args)
    return model

def train(model, feats, reals):
    epoch = 0
    while True:
        epoch += 1
        model.fit(feats, reals, verbose=None)
        metrics = model.evaluate(feats, reals, verbose=None)
        template = "\r%.6f %.6f %.6f"
        sys.stdout.write(template % tuple(metrics))
        if metrics[1] == 1:
            print()
            print(epoch)
            break

def calculateMetric(metric_):
    print("-----------------------")
    print("[%s]" % metric_.name)
    metric_.reset_state()
    print(metric_(_reals, _preds1))
    metric_.reset_state()
    print(metric_(_reals, _preds2))
    metric_.reset_state()
    print(metric_(_reals, _preds3))
    print("-----------------------")

def getArgs():
    return _args.copy()


@tf.function
def F1Score(reals, preds):
    _Precision.reset_state()
    _Recall.reset_state()
    precision = _Precision(reals, preds)
    recall = _Recall(reals, preds)
    return 2 * precision * recall / (precision + recall)


if __name__ == "__main__":

    print("[Physical Devices]")
    for device in tf.config.list_physical_devices():
        print("\t%s" % str(device))

    print(__question__)

    i2Metric = [
        tf.metrics.CategoricalAccuracy(),
        tf.metrics.BinaryAccuracy(),
        tf.metrics.CategoricalCrossentropy(),
        tf.metrics.BinaryCrossentropy()
    ]
    for Metric in i2Metric:
        calculateMetric(Metric)

    args = getArgs()
    args["optimizer"] = tf.optimizers.Adam()
    args["loss"] = tf.losses.BinaryCrossentropy()
    args["metrics"] += [tf.metrics.BinaryAccuracy(),
                        F1Score]

    model = getModel(args)

    train(model, _feats, _reals)

    preds = model.predict(_feats)
    print(preds)
    print(np.round(preds))
