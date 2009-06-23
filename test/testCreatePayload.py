#!/usr/bin/python
# vim:tw=0:expandtab:autoindent:tabstop=4:shiftwidth=4:filetype=python:
"""
"""

from __future__ import generators

import sys
import unittest
import os

exeName = os.path.realpath(sys.argv[0])
dirName = os.path.dirname(exeName)

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
        import xml.dom.minidom
        import dell_ft_pie_packager.create_payload as create_payload

        dom = xml.dom.minidom.parse(os.path.join(dirName, "package.xml"))
        actualResult = []
        expectedResult = [ 0x19A, ]

        for p in create_payload.getSystemDependencies(dom):
            actualResult.append(p)

        self.assertEqual(len(expectedResult), len(actualResult))
        for i in xrange(0,len(actualResult)):
            self.assertEqual(actualResult[i], expectedResult[i])

    def testCreatePayload_getOutputDirs(self):
        import xml.dom.minidom
        import dell_ft_pie_packager.create_payload as create_payload

        class DummyLogger(object):
            def info(a, b):
                return
        class Config(object):
            device_type_xsl = os.path.join(dirName, "..", "pkg", "DeviceType.xsl")

        create_payload.conf = Config()
        packageXml = os.path.join(dirName, "package.xml")
        dom = xml.dom.minidom.parse(packageXml)
        dom.filename = packageXml

        for packageIni, outdir in create_payload.getOutputDirs( dom, None, "dir", DummyLogger() ):
            self.assertEqual(outdir, "dir/dup/system_ven_0x1028_dev_0x019a/dell_dup_componentid_00159_version_a03")
            self.assertEqual(packageIni.get("package", "limit_system_support"), "ven_0x1028_dev_0x019a")
            self.assertEqual(packageIni.get("package", "name"), "dell_dup_componentid_00159")
            self.assertEqual(packageIni.get("package", "safe_name"), "dell_dup_componentid_00159")
            self.assertEqual(packageIni.get("package", "type"), "IEInterface")
            self.assertEqual(packageIni.get("package", "module"), "dell_ft_ie_interface")
            self.assertEqual(packageIni.get("package", "ie_type"), "BIOS_BIOS")
            self.assertEqual(packageIni.get("package", "displayname"), "Server System BIOS")
            self.assertEqual(packageIni.get("package", "version"), "a03")
            self.assertEqual(packageIni.get("package", "dell_version"), "a03")
            self.assertEqual(packageIni.get("package", "vendor_version"), "a03")

if __name__ == "__main__":
    import test.TestLib
    sys.exit(not test.TestLib.runTests( [TestCase] ))
