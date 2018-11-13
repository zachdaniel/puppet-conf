# conf
My puppet configuration

# IMPORTANT
There are a *lot* of assumptions in here about how I configure my machine.
Please read *every* file before you use this on your own. The way puppet works,
you need to do everything with sudo and I really don't want to be responsible
for something in this repo breaking your machine.

This repo assumes that you are using zsh as well, so if you are using bash or a
different shell you'd need to make a few important changes. It may also not work
right from the outset for you. I set it up a while ago, and there could
definitely be bugs with the setup script. I'd like to know them though, so let
me know if you find any!


## Setup:

* *read every file*
* *replace things with your preferred values/setup*
* the scripts are dumb and currently assumes my username. If you would like
  to make it generic, feel free to PR that. Otherwise, replace my info with yours.
* run `sudo scripts/conf-setup`
* run `sudo scripts/conf-apply` to apply your puppet configuration
