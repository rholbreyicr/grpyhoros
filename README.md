# grpyhoros

A library to connect python to a Horos or Osirix plugin using grpc. This is really a test/experimental project that was used as the starting point for osirixgrpc which is also on github (https://github.com/osirixgrpc). You might want to check there first, but this code has advanced sufficiently to be useful.

## Building
With Horos and Osirix being Mac tools, you'll need XCode and the grpc library. We're currently working with python 3.7 and grpcio 1.41.0.

Build instructions for grpc are given (very nicely) at: 
https://grpc.io/docs/languages/cpp/quickstart/

The project code here expects the link grpc to point to the install folder for your grpc (cmake) build.

## Installing binaries
Building grpc is a fairly long-winded process. If you want to skip that, you should be able to use the binary versions included here and with python, you can simply use:

pip install grpcio==1.41 

pip install grpcio-tools

and then, with the additional python files included here in the rpc/python folder, things should be good.

The recommended way to install plugins is to start the application (Horos or Osirix, either but *not* both) and double-click the relevant .osirixplugin package, which will then request admin permission. Once installed, you should be able to see the plugin listed under Plugins > Database > grpy(Horos/Osirix) and in the Plugins Manager. Selecting the plugin here opens a small console box, which can usually be ignored, but the first line contains the 'port' number needed to communicate with the plugin. 

In grpc-speak, the console is acting for the plugin server and gives brief output for each successful connection. A client (which might be in any supported language) can then connect using the files included in the 'rpc' folder in the source. We have only tested with python, hence the name.

If the plugin is not listed, see below.

## Switching off Gatekeeper
Since this is not a standard Apple developer package, you may encounter an issue with 'gatekeeper'. The only clean way to handle this is to disable it while installing the plugin.

- Open the Terminal application from Applications/Utilities
- Disable Gatekeeper by entering the following command: 

> su - admin
> 
> sudo spctl --master-disable

- Go to System Preferences/Security & Privacy. 
- Under the General tab, ensure that "Allow apps downloaded from" is selected as "Anywhere".
- Follow the steps for Installation (above), and then re-enable the Gatekeeper by typing the following command in Terminal:

> sudo spctl --master-enable

## Running an example
Once you have the plugin installed, you can run a demo by:-

- Opening a Terminal window
- cd'ing to the rpc folder
- Run eg. python python/horos_client.py [port]

If, for some reason, you need to set a different server port, you can create a file: 

~/.grpyHoros/config.txt

with your favourite text editor, containing just the desired port number.




