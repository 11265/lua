#!/bin/bash
set -e

# Create Xcode project directory
mkdir -p lua.xcodeproj

# Generate source file list
SOURCE_FILES=$(ls *.c | grep -v 'lua\.c\|onelua\.c\|ltests\.c')

# Create project file
{
  echo "// !$*UTF8*$!"
  echo "{"
  echo "  archiveVersion = 1;"
  echo "  classes = {};"
  echo "  objectVersion = 56;"
  echo "  objects = {"
  
  # PBXBuildFile section
  echo "    /* Begin PBXBuildFile section */"
  for file in $SOURCE_FILES; do
    build_uuid=$(uuidgen | tr -d - | cut -c1-24)
    ref_uuid=$(uuidgen | tr -d - | cut -c1-24)
    echo "    $build_uuid /* $file in Sources */ = {isa = PBXBuildFile; fileRef = $ref_uuid /* $file */; };"
    echo "REF_UUID_$file=$ref_uuid" >> /tmp/uuids.txt
  done
  echo "    /* End PBXBuildFile section */"
  
  # PBXFileReference section
  echo "    /* Begin PBXFileReference section */"
  for file in $SOURCE_FILES; do
    ref_uuid=$(grep "REF_UUID_$file" /tmp/uuids.txt | cut -d= -f2)
    echo "    $ref_uuid /* $file */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.c; path = $file; sourceTree = \"<group>\"; };"
  done
  echo "    8D1107320486CEB800E47090 /* liblua.a */ = {isa = PBXFileReference; explicitFileType = archive.ar; includeInIndex = 0; path = liblua.a; sourceTree = BUILT_PRODUCTS_DIR; };"
  echo "    /* End PBXFileReference section */"
  
  # PBXFrameworksBuildPhase section
  echo "    /* Begin PBXFrameworksBuildPhase section */"
  echo "    8D11072E0486CEB800E47090 /* Frameworks */ = {"
  echo "      isa = PBXFrameworksBuildPhase;"
  echo "      buildActionMask = 2147483647;"
  echo "      files = ();"
  echo "      runOnlyForDeploymentPostprocessing = 0;"
  echo "    };"
  echo "    /* End PBXFrameworksBuildPhase section */"
  
  # PBXGroup section
  echo "    /* Begin PBXGroup section */"
  echo "    29B97314FDCFA39411CA2CEA /* lua */ = {"
  echo "      isa = PBXGroup;"
  echo "      children = ("
  echo "        29B97315FDCFA39411CA2CEA /* Sources */,"
  echo "        19C28FACFE9D520D11CA2CBB /* Products */,"
  echo "      );"
  echo "      sourceTree = \"<group>\";"
  echo "    };"
  echo "    29B97315FDCFA39411CA2CEA /* Sources */ = {"
  echo "      isa = PBXGroup;"
  echo "      children = ("
  for file in $SOURCE_FILES; do
    ref_uuid=$(grep "REF_UUID_$file" /tmp/uuids.txt | cut -d= -f2)
    echo "        $ref_uuid /* $file */,"
  done
  echo "      );"
  echo "      sourceTree = \"<group>\";"
  echo "    };"
  echo "    19C28FACFE9D520D11CA2CBB /* Products */ = {"
  echo "      isa = PBXGroup;"
  echo "      children = ("
  echo "        8D1107320486CEB800E47090 /* liblua.a */,"
  echo "      );"
  echo "      sourceTree = \"<group>\";"
  echo "    };"
  echo "    /* End PBXGroup section */"
  
  # PBXNativeTarget section
  echo "    /* Begin PBXNativeTarget section */"
  echo "    8D1107260486CEB800E47090 /* lua */ = {"
  echo "      isa = PBXNativeTarget;"
  echo "      buildConfigurationList = 4D7A7B8A0ABF745500C91562 /* Build configuration list for PBXNativeTarget \"lua\" */;"
  echo "      buildPhases = ("
  echo "        8D1107290486CEB800E47090 /* Sources */,"
  echo "        8D11072E0486CEB800E47090 /* Frameworks */,"
  echo "      );"
  echo "      buildRules = ();"
  echo "      dependencies = ();"
  echo "      name = lua;"
  echo "      productName = lua;"
  echo "      productReference = 8D1107320486CEB800E47090 /* liblua.a */;"
  echo "      productType = \"com.apple.product-type.library.static\";"
  echo "    };"
  echo "    /* End PBXNativeTarget section */"
  
  # PBXProject section
  echo "    /* Begin PBXProject section */"
  echo "    29B97313FDCFA39411CA2CEA /* Project object */ = {"
  echo "      isa = PBXProject;"
  echo "      buildConfigurationList = 4D7A7B890ABF745500C91562 /* Build configuration list for PBXProject \"lua\" */;"
  echo "      compatibilityVersion = \"Xcode 14.0\";"
  echo "      developmentRegion = en;"
  echo "      hasScannedForEncodings = 1;"
  echo "      knownRegions = (en, Base);"
  echo "      mainGroup = 29B97314FDCFA39411CA2CEA /* lua */;"
  echo "      productRefGroup = 19C28FACFE9D520D11CA2CBB /* Products */;"
  echo "      projectDirPath = \"\";"
  echo "      projectRoot = \"\";"
  echo "      targets = (8D1107260486CEB800E47090 /* lua */);"
  echo "    };"
  echo "    /* End PBXProject section */"
  
  # PBXSourcesBuildPhase section
  echo "    /* Begin PBXSourcesBuildPhase section */"
  echo "    8D1107290486CEB800E47090 /* Sources */ = {"
  echo "      isa = PBXSourcesBuildPhase;"
  echo "      buildActionMask = 2147483647;"
  echo "      files = ("
  for file in $SOURCE_FILES; do
    build_uuid=$(uuidgen | tr -d - | cut -c1-24)
    ref_uuid=$(grep "REF_UUID_$file" /tmp/uuids.txt | cut -d= -f2)
    echo "        $build_uuid /* $file in Sources */,"
  done
  echo "      );"
  echo "      runOnlyForDeploymentPostprocessing = 0;"
  echo "    };"
  echo "    /* End PBXSourcesBuildPhase section */"
  
  # XCBuildConfiguration section
  echo "    /* Begin XCBuildConfiguration section */"
  echo "    4D7A7B8C0ABF745500C91562 /* Release */ = {"
  echo "      isa = XCBuildConfiguration;"
  echo "      buildSettings = {"
  echo "        ALWAYS_SEARCH_USER_PATHS = NO;"
  echo "        CLANG_ENABLE_OBJC_ARC = YES;"
  echo "        COPY_PHASE_STRIP = YES;"
  echo "        GCC_OPTIMIZATION_LEVEL = 3;"
  echo "        PRODUCT_NAME = lua;"
  echo "        EXECUTABLE_PREFIX = lib;"
  echo "        EXECUTABLE_EXTENSION = a;"
  echo "        MACH_O_TYPE = staticlib;"
  echo "        SKIP_INSTALL = NO;"
  echo "        SUPPORTED_PLATFORMS = \"iphoneos iphonesimulator\";"
  echo "        SUPPORTS_MACCATALYST = NO;"
  echo "        SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD = NO;"
  echo "        IPHONEOS_DEPLOYMENT_TARGET = 12.0;"
  echo "        \"ARCHS[sdk=iphoneos*]\" = arm64;"
  echo "        \"ARCHS[sdk=iphonesimulator*]\" = \"x86_64 arm64\";"
  echo "        SDKROOT = iphoneos;"
  echo "        TARGETED_DEVICE_FAMILY = \"1,2\";"
  echo "        ENABLE_BITCODE = NO;"
  echo "        HEADER_SEARCH_PATHS = ("
  echo "          \"\$(inherited)\","
  echo "          \"\$(SRCROOT)\","
  echo "        );"
  echo "        GCC_PREPROCESSOR_DEFINITIONS = ("
  echo "          \"\$(inherited)\","
  echo "          \"LUA_USE_POSIX=1\","
  echo "        );"
  echo "        CLANG_ENABLE_MODULES = NO;"
  echo "        DEAD_CODE_STRIPPING = YES;"
  echo "        ONLY_ACTIVE_ARCH = NO;"
  echo "        DEPLOYMENT_LOCATION = YES;"
  echo "        STRIP_INSTALLED_PRODUCT = NO;"
  echo "        GENERATE_MASTER_OBJECT_FILE = NO;"
  echo "        LINK_WITH_STANDARD_LIBRARIES = YES;"
  echo "        COMBINE_HIDPI_IMAGES = NO;"
  echo "        LIBRARY_STYLE = STATIC;"
  echo "        CONFIGURATION_BUILD_DIR = \"\$(BUILD_DIR)/\$(CONFIGURATION)-\$(PLATFORM_NAME)\";"
  echo "        SYMROOT = \"\$(BUILD_DIR)\";"
  echo "        OBJROOT = \"\$(BUILD_DIR)\";"
  echo "        BUILT_PRODUCTS_DIR = \"\$(BUILD_DIR)/\$(CONFIGURATION)-\$(PLATFORM_NAME)\";"
  echo "        TARGET_BUILD_DIR = \"\$(BUILD_DIR)/\$(CONFIGURATION)-\$(PLATFORM_NAME)\";"
  echo "        INSTALL_PATH = \"\$(TARGET_BUILD_DIR)\";"
  echo "        PUBLIC_HEADERS_FOLDER_PATH = \"\$(TARGET_BUILD_DIR)/include\";"
  echo "        DSTROOT = \"\$(TARGET_BUILD_DIR)\";"
  echo "        CLANG_ENABLE_OBJC_WEAK = NO;"
  echo "        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;"
  echo "        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;"
  echo "        CLANG_WARN_EMPTY_BODY = YES;"
  echo "        CLANG_WARN_BOOL_CONVERSION = YES;"
  echo "        CLANG_WARN_CONSTANT_CONVERSION = YES;"
  echo "        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;"
  echo "        CLANG_WARN_ENUM_CONVERSION = YES;"
  echo "        CLANG_WARN_INT_CONVERSION = YES;"
  echo "        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;"
  echo "        CLANG_WARN_INFINITE_RECURSION = YES;"
  echo "        GCC_WARN_ABOUT_RETURN_TYPE = YES;"
  echo "        GCC_WARN_UNINITIALIZED_AUTOS = YES;"
  echo "        CLANG_WARN_UNREACHABLE_CODE = YES;"
  echo "        GCC_WARN_UNUSED_FUNCTION = YES;"
  echo "        GCC_WARN_UNUSED_VARIABLE = YES;"
  echo "        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;"
  echo "        ENABLE_STRICT_OBJC_MSGSEND = YES;"
  echo "        GCC_NO_COMMON_BLOCKS = YES;"
  echo "        ENABLE_TESTABILITY = NO;"
  echo "        VALIDATE_PRODUCT = YES;"
  echo "      };"
  echo "      name = Release;"
  echo "    };"
  echo "    /* End XCBuildConfiguration section */"
  
  # XCConfigurationList section
  echo "    /* Begin XCConfigurationList section */"
  echo "    4D7A7B890ABF745500C91562 /* Build configuration list for PBXProject \"lua\" */ = {"
  echo "      isa = XCConfigurationList;"
  echo "      buildConfigurations = (4D7A7B8C0ABF745500C91562 /* Release */);"
  echo "      defaultConfigurationIsVisible = 0;"
  echo "      defaultConfigurationName = Release;"
  echo "    };"
  echo "    4D7A7B8A0ABF745500C91562 /* Build configuration list for PBXNativeTarget \"lua\" */ = {"
  echo "      isa = XCConfigurationList;"
  echo "      buildConfigurations = (4D7A7B8C0ABF745500C91562 /* Release */);"
  echo "      defaultConfigurationIsVisible = 0;"
  echo "      defaultConfigurationName = Release;"
  echo "    };"
  echo "    /* End XCConfigurationList section */"
  echo "  };"
  echo "  rootObject = 29B97313FDCFA39411CA2CEA /* Project object */;"
  echo "}"
} > lua.xcodeproj/project.pbxproj

rm -f /tmp/uuids.txt

echo "Generated Xcode project at lua.xcodeproj"
echo "Source files included:"
echo "$SOURCE_FILES" 