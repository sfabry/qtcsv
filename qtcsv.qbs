import qbs 1.0

Product  {
    type: ["dynamiclibrary"]
    name: "qtcsv"

    Depends { name: "cpp" }
    Depends { name: "Qt.core" }

    cpp.defines: ["QTCSV_LIBRARY"]
    cpp.includePaths: [".", "include"]

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: [product.sourceDirectory, product.sourceDirectory + "/include"]
    }

    files: [
        "include/qtcsv/abstractdata.h",
        "include/qtcsv/qtcsv_global.h",
        "include/qtcsv/reader.h",
        "include/qtcsv/stringdata.h",
        "include/qtcsv/variantdata.h",
        "include/qtcsv/writer.h",
        "sources/contentiterator.cpp",
        "sources/contentiterator.h",
        "sources/filechecker.h",
        "sources/reader.cpp",
        "sources/stringdata.cpp",
        "sources/symbols.h",
        "sources/variantdata.cpp",
        "sources/writer.cpp",
    ]

    Group {
        fileTagsFilter: "dynamiclibrary"
        qbs.install: true
        qbs.installDir: "vaccine-lab"
    }
}
