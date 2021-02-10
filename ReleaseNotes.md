* 0.1.0
pyOsiriXII python interface to OsiriX, fundamentally changing original pyOsiriX by separating python via grpc (instead of embedding via cpython).
"II" is used instead of "2" because OsiriX forbids the use of numbers in plugin names.

* 0.2.0
grpyHoros and grpyOsiriX are developed as separate projects within the same bundle as seem to require separate project settings, though otherwise the code seems to be sharable.
"grpy" is supposed to reflect use of grpc to enable the separation whilst supporting python, as much as possible, like the original project. Get/Set current image metadata.
* 0.2.1
Get/Set current image. pyosirix is used as the package namespace. Versioning added.
* 0.2.2
Retrieve ROIs
* 0.2.3
Set ROIs
* 0.2.4
Check if viewerWindow is open at current image/roi.... open if not, using db call (as eg xmlrpc).

* 0.3.0
Introducing ssl/tls encryption.
