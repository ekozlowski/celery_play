celery_play
===========

Building an example of an image resizing backend using Celery for image processing.

Not getting fancy with the spices, just being really simple in deferring workloads.

I will be covering this in a talk at DFW Pythoneers monthly meeting on Saturday,
October 10, 2015 at Improving Enterprises.

Requirements
============

- Written on Mac OS X, Yosemite
- Vagrant (tested with 1.7.4)
- Virtualbox (tested with 5.0.4)

Instructions
------------

- Open Two Terminal Windows

First Window
------------

- `git clone git@github.com:ekozlowski/celery_play.git`
- `cd celery_play/image_resizer`
- `virtualenv .`
- `source ./bin/activate`
- `pip install -r ./requirements.txt`
- `python ./main.py`

( you should be able to browse to localhost:5000, and get the file upload page! )

Second Window
-------------

- `cd celery_play (above)/asset_server`
- `vagrant up`
- (wait for finish)
- `vagrant ssh`
- `cd /opt/processes`
- `celery -A celery_tasks worker --loglevel=INFO`

( you should see this, or something similar )

```
[2015-10-10 17:16:58,340: WARNING/MainProcess] celery@worker ready.
```


Should I use this in Production?
================================

No.  Google "No No Cat".  :)

Can I use this?
===============

Sure, but you assume all responsibility.  This is MIT Licensed.


