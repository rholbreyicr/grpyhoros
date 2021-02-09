* 0.1.0
pyOsiriXII python interface to OsiriX, fundamentally changing original pyOsiriX by separating python via grpc (instead of embedding python via cpython).
"II" is used instead of "2" because OsiriX forbids the use of numbers in plugin names.

* 0.2.0
grpyHoros and grpyOsiriX are developed as separate projects within the same bundle as seem to require separate project settings, though otherwise the code seems to be sharable.
"grpy" is supposed to reflect use of grpc to enable the separation whilst supporting python, as much as possible, like the original project.
* 0.2.1
pyosirix is used as the package namespace.
* 0.2.2
Introducing ssl/tls encryption.
