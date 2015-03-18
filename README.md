# timelapse

With *timelapse* you can create movies using time-lapse photography taken with
your webcam. The result can look something like this:

[(EXAMPLE)](https://www.youtube.com/watch?v=NIG4t16QVZU)

...

*timelapse* consists of two scripts:

`take-snapshot.sh` takes a snapshot with your webcam and should be called
periodically, e.g. using a cronjob.

`render-movie.sh` uses the snapshots taken so far and renders a 24fps movie out
of them.

## Requirements

* sh or bash
* [fswebcam](https://github.com/fsphil/fswebcam)
* [Mencoder from MPlayer](http://www.mplayerhq.hu/)
* A webcam ;-)

## Setup

To install the required software under Ubuntu or any other Debian-based Linux,
simply do a:

```
apt-get install fswebcam mencoder
```

...

## The Scripts

### take-snapshot.sh

...

#### Configuration

...

### render-movie.sh

#### Configuration

...

