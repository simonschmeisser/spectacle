--- output.orig.spec	2010-09-18 20:50:28.332208173 +0800
+++ output.spec	2010-09-18 20:50:28.434208377 +0800
@@ -14,6 +14,7 @@ License:    BSD
 URL:        http://www.testpkg.org/
 Source0:    http://www.testpkg.org/testpkg-%{version}.tar.gz
 Source100:  testpkg.yaml
+BuildRoot:  %{_tmppath}/%{name}-%{version}-build
 
 
 %description
@@ -42,14 +43,38 @@ This package contains development files
 # >> build pre
 # << build pre
 
+%if 0%{?moblin_version}
+%qmake  \
+%else
+qmake -makefile -nocache \
+  "QMAKE_CFLAGS_RELEASE=${CFLAGS:-%optflags}" \
+  "QMAKE_CFLAGS_DEBUG=${CFLAGS:-%optflags}" \
+  "QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS:-%optflags}" \
+  "QMAKE_CXXFLAGS_DEBUG=${CXXFLAGS:-%optflags}" \
+  QMAKE_STRIP=: \
+  PREFIX=%{_prefix}  \
+%endif
+%ifarch %{arm}
+    --arm-only \
+%endif
+%ifarch %{ix86}
+    --ix86-only \
+%endif
+    --common-one
 
+make %{?jobs:-j%jobs}
 
 # >> build post
 # << build post
 %install
-rm -rf %{buildroot}
+rm -rf $RPM_BUILD_ROOT
 # >> install pre
 # << install pre
+%if 0%{?moblin_version}
+%qmake_install
+%else
+%makeinstall
+%endif
 
 # >> install post
 # << install post