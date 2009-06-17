#!/usr/bin/python
# vim:tw=0:expandtab:autoindent:tabstop=4:shiftwidth=4:filetype=python:
"""
"""

from __future__ import generators

import sys
import unittest

class TestCase(unittest.TestCase):
    def setUp(self):
        if globals().get('dell_ft_pie_packager'): del(dell_ft_pie_packager)
        for k in sys.modules.keys():
            if k.startswith("dell_ft_pie_packager"):
                del(sys.modules[k])

    def tearDown(self):
        if globals().get('dell_ft_pie_packager'): del(dell_ft_pie_packager)
        for k in sys.modules.keys():
            if k.startswith("dell_ft_pie_packager"):
                del(sys.modules[k])

    def testCreatePayload_sysdep(self):
        import dell_ft_pie_packager.create_payload as create_payload
        dom = xml.dom.minidom.parse("package.xml")
        actualResult = []
        expectedResult = [ 0x19A, ]
        for p in create_payload.getSystemDependencies(dom):
            actualResult.append(p)

        self.assertEqual(len(expectedResult), len(actualResult))
        for i in xrange(0,len(actualResult)):
            self.assertEqual(actualResult[i], expectedResult[i])

if __name__ == "__main__":
    import test.TestLib
    sys.exit(not test.TestLib.runTests( [TestCase] ))
