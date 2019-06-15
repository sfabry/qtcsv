QT += testlib
QT -= gui

TARGET = qtcsv_tests
CONFIG += console testcase
CONFIG -= app_bundle

TEMPLATE = app

!msvc {
    # flags for gcc-like compiler
    CONFIG += warn_on
    QMAKE_CXXFLAGS_WARN_ON += -Werror -Wformat=2 -Wuninitialized -Winit-self \
            -Wmissing-include-dirs -Wswitch-enum -Wundef -Wpointer-arith \
            -Wdisabled-optimization -Wcast-align -Wcast-qual
}

# set where linker could find qtcsv library. By default we expect
# that library is located in the same directory as the qtcsv_tests binary.
QTCSV_LOCATION = $$OUT_PWD
LIBS += -L$$QTCSV_LOCATION -lqtcsv

# Uncomment this settings if you want to manually set destination directory for
# compiled binary
#CONFIG(release, debug|release): DESTDIR = $$PWD/../
#CONFIG(debug, debug|release): DESTDIR = $$PWD/../

INCLUDEPATH += $$PWD/../include

SOURCES += \
    tst_testmain.cpp \
    teststringdata.cpp \
    testvariantdata.cpp \
    testreader.cpp \
    testwriter.cpp

HEADERS += \
    teststringdata.h \
    testvariantdata.h \
    testreader.h \
    testwriter.h

DISTFILES += \
    CMakeLists.txt

!equals(PWD, $$OUT_PWD){
    win32 {
        COPY_FROM_PATH=$$shell_path($$PWD/data)
        COPY_TO_PATH=$$shell_path($$OUT_PWD/data)
    }
    else {
        COPY_FROM_PATH=$$PWD/data
        COPY_TO_PATH=$$OUT_PWD
    }

    prepare_test_files.target = prepare_test_files
    prepare_test_files.depends = createdir copydata unzip_wcp

    # Create 'data' dir in output folder
    createdir.commands = @echo "Going to create $$COPY_TO_PATH" && $(MKDIR) $$COPY_TO_PATH

    # Copy 'data' folder with test files to the destination directory
    copydata.commands = @echo "Going to copy test files" && $(COPY_DIR) $$COPY_FROM_PATH $$COPY_TO_PATH

    # Unzip test archives
    WCP_ZIP=worldcitiespop.zip
    win32 {
        # TODO: unzip archive on windows
        #unzip_wcp.commands = Expand-Archive -LiteralPath $$COPY_TO_PATH\\$$WCP_ZIP -DestinationPath $$COPY_TO_PATH
        unzip_wcp.commands = @echo "Skipping unzipping of $$WCP_ZIP"
    }
    else {
        unzip_wcp.commands = unzip $$COPY_TO_PATH/data/$$WCP_ZIP -d $$COPY_TO_PATH/data
    }

    QMAKE_EXTRA_TARGETS += prepare_test_files createdir copydata unzip_wcp
}

message(=== Configuration of qtcsv_tests ===)
message(Qt version: $$[QT_VERSION])
message(qtcsv_tests binary will be created in folder: $$OUT_PWD)
message(Expected location of qtcsv library: $$QTCSV_LOCATION)
message(Expected location of \"data\" folder with test files: $$OUT_PWD)
