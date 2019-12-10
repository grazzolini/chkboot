=======
chkboot
=======

---------------------------------------------------------------
checks for unwanted modification on unencrypted /boot partition
---------------------------------------------------------------

:Author: Ju <ju@heisec.de>, Giancarlo Razzolini <grazzolini@gmail.com>,
         Chris Warner <inhies@gmail.com> and Kevin MacMartin <prurigro@gmail.com>
:Date: 2019-04-17
:Copyright: GPL-2
:Version: 1.3
:Manual section: 8
:Manual group: System Manager's Manual

SYNOPSIS
========

``chkboot`` [OPTIONS]

DESCRIPTION
===========

Checks for any modification to your boot files since last run.

--update, -u            Mark changes as valid. Next run of ``chkboot`` will not
                        warn about differences.
--help, -h              Show this help message and exit.


``chkboot`` runs at system startup to check for boot files modifications. User
will be warn upon login if any are found.

Kernel upgrade are automatically marked as valid.

Configurations, such as boot partition, can be edited in:

  ``/etc/default/chkboot``

EXAMPLES
========

Acknowledge a detected changed after ``chkboot`` have displayed a warning:

  ``chkboot``

Clear valid modifications made by users:

  ``chkboot -u``

SEE ALSO
========

* ``man chkboot-check`` and ``man chkboot-desktopalert``

BUGS
====

* GPT partitions are not supported. As chkboot will continue to work, it **will
  not report changes in GPT headers** (only protective MBR).
