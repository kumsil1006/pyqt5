Differences Between PyQt4 and PyQt5
===================================

PyQt5 is not compatibile with PyQt4 (although experience shows that the effort
in porting applications from PyQt4 to PyQt5 is not great).  This section
describes the main differences between the two.


Supported Python Versions
-------------------------

Versions of Python earlier than v2.6 are not supported.


Deprecated Features
-------------------

PyQt5 does not support any parts of the Qt API that are marked as deprecated or
obsolete in Qt v5.0.  However it is possible that some of these have been
included accidentaly.  These are considered bugs and will be removed if found.


Multiple APIs
-------------

PyQt4 supports a number of different API versions (``QString``,
:class:`~PyQt5.QtCore.QVariant` etc.).  With the exception of
:class:`~PyQt5.QtCore.QVariant`, PyQt5 only implements v2 of those APIs for all
versions of Python.  The changed support for :class:`~PyQt5.QtCore.QVariant`,
including the removal of ``QPyNullVariant``) is described in
:ref:`ref-qvariant`.


Old-style Signals and Slots
---------------------------

PyQt4's old-style signals and slots are not supported.  Therefore the following
are not implemented in PyQt5:

- ``QObject.connect()``

- ``QObject.emit()``

- ``SIGNAL()``

- ``SLOT()``

All methods that had arguments that are usually the results of calls to
``SIGNAL()`` or ``SLOT()`` are no longer supported.  There will always be an
equivalent that takes a bound signal or callable respectively.

In addition the following methods have differences:

- :meth:`~PyQt5.QtCore.QObject.disconnect` takes no arguments and disconnects
  all connections to the :class:`~PyQt5.QtCore.QObject` instance.


``QtDeclarative`` Module
------------------------

PyQt4's ``QtDeclarative`` module is not supported.  A future release of PyQt5
will implement a ``QtQuick`` module.


``QtGui`` Module
----------------

PyQt4's ``QtGui`` module has been split into PyQt5's :mod:`QtGui`,
:mod:`QtPrintSupport` and :mod:`QtWidgets` modules.


``QtOpenGL`` Module
-------------------

Only the :class:`~PyQt5.QtOpenGL.QGLContext`,
:class:`~PyQt5.QtOpenGL.QGLFormat` and :class:`~PyQt5.QtOpenGL.QGLWidget`
classes are supported by PyQt5.


``QtScript`` and ``QtScriptTools`` Modules
------------------------------------------

PyQt4's ``QtScript`` and ``QtScriptTools`` modules are not supported.  A future
release of PyQt5 will implement a ``QtQml`` module.


``QtWebKit`` Module
-------------------

PyQt4's ``QtWebKit`` module has been split into PyQt5's :mod:`QtWebKit` and
:mod:`QtWebKitWidgets` modules.


``QtXml`` Module
----------------

PyQt4's ``QtXml`` module is not supported.  Use either the
:class:`~PyQt5.QtCore.QXMLStreamReader` and
:class:`~PyQt5.QtCore.QXMLStreamWriter` classes or Python's standard XML
modules.


``pyqtconfig`` Module
---------------------

PyQt4's ``pyqtconfig`` module is not supported.  The section
:ref:`ref-build-system` describes the support that PyQt5 provides to
third-party packages (e.g.
`QScintilla <http://www.riverbankcomputing.com/software/qscintilla/>`__) that
want to build on top of PyQt5.


``QDataStream``
---------------

The :meth:`~PyQt5.QtCore.QDataStream.readUInt8`,
:meth:`~PyQt5.QtCore.QDataStream.readInt8`,
:meth:`~PyQt5.QtCore.QDataStream.writeUInt8` and
:meth:`~PyQt5.QtCore.QDataStream.writeInt8` methods all interpret the values
being read and written as numeric values.  In PyQt4 they are interpreted as
single character strings.


``QFileDialog``
---------------

The ``getOpenFileNameAndFilter()``, ``getOpenFileNamesAndFilter()`` and
``getSaveFileNameAndFilter()`` methods of PyQt4's ``QFileDialog`` have now been
renamed :meth:`~PyQt5.QtWidgets.QFileDialog.getOpenFileName`,
:meth:`~PyQt5.QtWidgets.QFileDialog.getOpenFileNames` and
:meth:`~PyQt5.QtWidgets.QFileDialog.getSaveFileName` respectively in PyQt5.
PyQt4's implementations of ``getOpenFileName()``, ``getOpenFileNames()`` and
``getSaveFileName()`` are not supported in PyQt5.


``QGraphicsItemAnimation``
--------------------------

Support for the deprecated ``QGraphicsItemAnimation`` class has been removed.
If porting an existing PyQt4 application then consider first updating it to use
:class:`~PyQt5.QtCore.QPropertyAnimation` instead.


``QMatrix``
-----------

Support for the deprecated ``QMatrix`` class has been removed.  If porting an
existing PyQt4 application then consider first updating it to use
:class:`~PyQt5.QtGui.QTransform` instead.


``QSet``
--------

In PyQt4, ``QSet`` was implemented as a list in Python v2 and a set in Python
v3.  In PyQt5 ``QSet`` is always implemented as a set.


``pyuic5``
----------

:program:`pyuic5` does not support the ``--pyqt3-wrapper`` flag of ``pyuic4``.


``pyrcc5``
----------

:program:`pyrcc5` does not support the ``-py2`` and ``-py3`` flags of
``pyrcc4``.  The output of :program:`pyrcc5` is compatible with all versions of
Python starting with Python v2.6.


Releasing the GIL
-----------------

The GIL is only released when it is known to be needed.  PyQt4 always released
the GIL when calling Qt.


Object Destruction on Exit
--------------------------

When the Python interpreter exits PyQt4 (by default) calls the C++ destructor
of all wrapped instances that it owns.  This happens in a random order and can
therefore cause the interpreter to crash.  This behavior can be disabled by
calling the :func:`sip.setdestroyonexit` function.

PyQt5 always calls :func:`sip.setdestroyonexit` automatically.
