# docker-sumo-python

[![](https://images.microbadger.com/badges/version/dbuse/sumo-python.svg)](https://microbadger.com/images/dbuse/sumo-python)
[![](https://images.microbadger.com/badges/image/dbuse/sumo-python.svg)](https://microbadger.com/images/dbuse/sumo-python)

Containerised SUMO with a custom python interpreter ready to run `TraCI`-enabled scripts

[SUMO (Simulation of Urban MObility)](http://sumo.dlr.de/wiki/Simulation_of_Urban_MObility_-_Wiki), an open-source traffic simulation software, is dockeried by the `Dockerfile`s included in this repository.
This image is based on the [base python image](https://hub.docker.com/_/python) in the debian flavour and provides containers with different versions of Python and SUMO.

## References

This repository is based on [https://github.com/bogaotory/docker-sumo](bogaotory/docker-sumo).
But the focus is no longer on a gui-runnable sumo container but provinding an image for python scripts using SUMO and TraCI.

Other references made by [https://github.com/bogaotory](bogaotory) for his designs:

- [https://github.com/radiganm/dockerhub](https://github.com/radiganm/dockerhub), which insists on compiling everything from source
- [https://github.com/similitude/sumo-docker](https://github.com/similitude/sumo-docker), based on Maven and emphasises on the inclusion of `TraCI4J` which is not necessarily useful for beginners of SUMO.

Neither gives a straightforward containerised SUMO solution.

The method for GUI access is borrowed from [this post](http://wiki.ros.org/docker/Tutorials/GUI).
