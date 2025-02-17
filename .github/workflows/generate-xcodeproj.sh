#!/bin/bash

# Create Xcode project directory
mkdir -p lua.xcodeproj

# Generate source file list
SOURCE_FILES=$(ls *.c | grep -v 'lua.c\|onelua.c\|ltests.c')

# Create temporary project file
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
    UUID1=$(uuidgen | tr -d - | cut -c1-24)
    UUID2=$(uuidgen | tr -d - | cut -c1-24)
    echo "    $UUID1 /* $file in Sources */ = {isa = PBXBuildFile; fileRef = $UUID2 /* $file */; };"
  done
  echo "    /* End PBXBuildFile section */"
  
  # PBXFileReference section
  echo "    /* Begin PBXFileReference section */"
  for file in $SOURCE_FILES; do
    UUID=$(uuidgen | tr -d - | cut -c1-24)
    echo "    $UUID /* $file */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.c; path = $file; sourceTree = \"<group>\"; };"
  done
  echo "    8D1107320486CEB800E47090 /* liblua.a */ = {isa = PBXFileReference; explicitFileType = archive.ar; includeInIndex = 0; path = liblua.a; sourceTree = BUILT_PRODUCTS_DIR; };"
  echo "    /* End PBXFileReference section */"
  
  # PBXFrameworksBuildPhase section
  cat << "EOFFW"
    /* Begin PBXFrameworksBuildPhase section */
    8D11072E0486CEB800E47090 /* Frameworks */ = {
      isa = PBXFrameworksBuildPhase;
      buildActionMask = 2147483647;
      files = (
      );
      runOnlyForDeploymentPostprocessing = 0;
    };
    /* End PBXFrameworksBuildPhase section */
EOFFW
  
  # PBXGroup section
  echo "    /* Begin PBXGroup section */"
  echo "    29B97314FDCFA39411CA2CEA /* lua */ = {"
  echo "      isa = PBXGroup;"
  echo "      children = ("
  for file in $SOURCE_FILES; do
    UUID=$(uuidgen | tr -d - | cut -c1-24)
    echo "        $UUID /* $file */,"
  done
  echo "      );"
  echo "      sourceTree = \"<group>\";"
  echo "    };"
  echo "    /* End PBXGroup section */"
  
  # Add remaining sections
  cat << "EOFREM"
    /* Begin PBXNativeTarget section */
    8D1107260486CEB800E47090 /* lua */ = {
      isa = PBXNativeTarget;
      buildConfigurationList = 4D7A7B8A0ABF745500C91562 /* Build configuration list for PBXNativeTarget "lua" */;
      buildPhases = (
        8D1107290486CEB800E47090 /* Sources */,
        8D11072E0486CEB800E47090 /* Frameworks */,
      );
      buildRules = (
      );
      dependencies = (
      );
      name = lua;
      productName = lua;
      productReference = 8D1107320486CEB800E47090 /* liblua.a */;
      productType = "com.apple.product-type.library.static";
    };
    /* End PBXNativeTarget section */
    
    /* Begin PBXProject section */
    29B97313FDCFA39411CA2CEA /* Project object */ = {
      isa = PBXProject;
      buildConfigurationList = 4D7A7B890ABF745500C91562 /* Build configuration list for PBXProject "lua" */;
      compatibilityVersion = "Xcode 14.0";
      developmentRegion = en;
      hasScannedForEncodings = 1;
      knownRegions = (
        en,
        Base,
      );
      mainGroup = 29B97314FDCFA39411CA2CEA /* lua */;
      productRefGroup = 29B97314FDCFA39411CA2CEA /* lua */;
      projectDirPath = "";
      projectRoot = "";
      targets = (
        8D1107260486CEB800E47090 /* lua */,
      );
    };
    /* End PBXProject section */
    
    /* Begin PBXSourcesBuildPhase section */
    8D1107290486CEB800E47090 /* Sources */ = {
      isa = PBXSourcesBuildPhase;
      buildActionMask = 2147483647;
      files = (
EOFREM

  for file in $SOURCE_FILES; do
    echo "        $(uuidgen | tr -d - | cut -c1-24) /* $file in Sources */,"
  done

  cat << "EOFEND"
      );
      runOnlyForDeploymentPostprocessing = 0;
    };
    /* End PBXSourcesBuildPhase section */
    
    /* Begin XCBuildConfiguration section */
    4D7A7B8C0ABF745500C91562 /* Release */ = {
      isa = XCBuildConfiguration;
      buildSettings = {
        ALWAYS_SEARCH_USER_PATHS = NO;
        CLANG_ENABLE_OBJC_ARC = YES;
        COPY_PHASE_STRIP = YES;
        GCC_OPTIMIZATION_LEVEL = 3;
        PRODUCT_NAME = "$(TARGET_NAME)";
        SKIP_INSTALL = NO;
        SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";
        SUPPORTS_MACCATALYST = NO;
        SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD = NO;
        IPHONEOS_DEPLOYMENT_TARGET = 12.0;
        "ARCHS[sdk=iphoneos*]" = arm64;
        "ARCHS[sdk=iphonesimulator*]" = "x86_64 arm64";
        SDKROOT = iphoneos;
        TARGETED_DEVICE_FAMILY = "1,2";
        ENABLE_BITCODE = NO;
        HEADER_SEARCH_PATHS = (
          "$(inherited)",
          "$(SRCROOT)",
        );
        GCC_PREPROCESSOR_DEFINITIONS = (
          "$(inherited)",
          "LUA_USE_POSIX=1",
        );
      };
      name = Release;
    };
    /* End XCBuildConfiguration section */
    
    /* Begin XCConfigurationList section */
    4D7A7B890ABF745500C91562 /* Build configuration list for PBXProject "lua" */ = {
      isa = XCConfigurationList;
      buildConfigurations = (
        4D7A7B8C0ABF745500C91562 /* Release */,
      );
      defaultConfigurationIsVisible = 0;
      defaultConfigurationName = Release;
    };
    4D7A7B8A0ABF745500C91562 /* Build configuration list for PBXNativeTarget "lua" */ = {
      isa = XCConfigurationList;
      buildConfigurations = (
        4D7A7B8C0ABF745500C91562 /* Release */,
      );
      defaultConfigurationIsVisible = 0;
      defaultConfigurationName = Release;
    };
    /* End XCConfigurationList section */
  };
  rootObject = 29B97313FDCFA39411CA2CEA /* Project object */;
}
EOFEND
} > lua.xcodeproj/project.pbxproj 