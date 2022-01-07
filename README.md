# Screenlapse
A simple repo to create a recording of your screen using a series of screenshots
automatically taken and sown together. Images are checked for noticeable 
changes in the images before being fully saved. All images will be saved in a
relative `.scarchive` directory.


## Installation
Install it yourself as:

    $ gem install screenlapse


## Running
Refer to `screenlapse help` for full usage. 

To start a session, run `screenlapse record` and leave it running in the 
background. When done, Control-C to stop the recording. `screenlapse render` 
can then be used to compile the images into one video.


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


[foreman]: https://github.com/ddollar/foreman
