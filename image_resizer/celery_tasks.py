from celery import Celery
import time
import random
import os
import io

app = Celery('celery_tasks', backend='rpc://', broker='amqp://guest@localhost//')
ASSET_DIR = '/opt/assets/'

import os, sys
from PIL import Image

@app.task
def process(filename, filedata):
    for method in (copy_to_asset_dir, resize_to_medium, resize_to_thumbnail,):
        method.delay(filename, filedata)

@app.task
def copy_to_asset_dir(filename, filedata):
    open(os.path.join(ASSET_DIR, filename), 'w').write(filedata)
    print("Done writing {} to {}".format(filename, ASSET_DIR))

def _resize(size, filedata):
    img = Image.open(io.BytesIO(bytearray(filedata)))
    return img.resize(size, Image.ANTIALIAS)
    
@app.task
def resize_to_medium(filename, filedata):
    # split_the_filename to filename_med.(ext)
    fn, ext = os.path.splitext(filename)
    newfn = "{}_med{}".format(fn, ext)
    img = _resize((500, 500), filedata)
    img.save(os.path.join(ASSET_DIR, newfn), "JPEG")

@app.task
def resize_to_thumbnail(filename, filedata):
    fn, ext = os.path.splitext(filename)
    newfn = "{}_thumbnail{}".format(fn, ext)
    img = _resize((150, 150), filedata)
    img.save(os.path.join(ASSET_DIR, newfn), "JPEG")

@app.task
def add(x, y):
    return x + y