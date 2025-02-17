#!/bin/bash
set -e

# Create Xcode project directory
mkdir -p lua.xcodeproj

# Generate source file list
SOURCE_FILES=$(ls *.c | grep -v 'lua\.c\|onelua\.c\|ltests\.c')

# Create project file
cat > lua.xcodeproj/project.pbxproj << 'EOL'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {
EOL

# Generate UUIDs for files
echo "/* Begin PBXBuildFile section */" >> lua.xcodeproj/project.pbxproj
for file in $SOURCE_FILES; do
    build_uuid=$(uuidgen | tr -d - | cut -c1-24)
    ref_uuid=$(uuidgen | tr -d - | cut -c1-24)
    echo "		$build_uuid /* $file in Sources */ = {isa = PBXBuildFile; fileRef = $ref_uuid /* $file */; };" >> lua.xcodeproj/project.pbxproj
    echo "REF_UUID_$file=$ref_uuid" >> /tmp/uuids.txt
done
echo "/* End PBXBuildFile section */" >> lua.xcodeproj/project.pbxproj

# PBXFileReference section
echo "/* Begin PBXFileReference section */" >> lua.xcodeproj/project.pbxproj
for file in $SOURCE_FILES; do
    ref_uuid=$(grep "REF_UUID_$file" /tmp/uuids.txt | cut -d= -f2)
    echo "		$ref_uuid /* $file */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.c; path = $file; sourceTree = \"<group>\"; };" >> lua.xcodeproj/project.pbxproj
done
echo "		8D1107320486CEB800E47090 /* liblua.a */ = {isa = PBXFileReference; explicitFileType = archive.ar; includeInIndex = 0; path = liblua.a; sourceTree = BUILT_PRODUCTS_DIR; };" >> lua.xcodeproj/project.pbxproj
echo "/* End PBXFileReference section */" >> lua.xcodeproj/project.pbxproj

cat >> lua.xcodeproj/project.pbxproj << 'EOL'
/* Begin PBXFrameworksBuildPhase section */
		8D11072E0486CEB800E47090 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		29B97314FDCFA39411CA2CEA /* lua */ = {
			isa = PBXGroup;
			children = (
				29B97315FDCFA39411CA2CEA /* Sources */,
				19C28FACFE9D520D11CA2CBB /* Products */,
			);
			sourceTree = "<group>";
		};
		29B97315FDCFA39411CA2CEA /* Sources */ = {
			isa = PBXGroup;
			children = (
EOL

# Add source files to PBXGroup
for file in $SOURCE_FILES; do
    ref_uuid=$(grep "REF_UUID_$file" /tmp/uuids.txt | cut -d= -f2)
    echo "				$ref_uuid /* $file */," >> lua.xcodeproj/project.pbxproj
done

cat >> lua.xcodeproj/project.pbxproj << 'EOL'
			);
			sourceTree = "<group>";
		};
		19C28FACFE9D520D11CA2CBB /* Products */ = {
			isa = PBXGroup;
			children = (
				8D1107320486CEB800E47090 /* liblua.a */,
			);
			sourceTree = "<group>";
		};
/* End PBXGroup section */

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
			productRefGroup = 19C28FACFE9D520D11CA2CBB /* Products */;
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
EOL

# Add source files to PBXSourcesBuildPhase
for file in $SOURCE_FILES; do
    build_uuid=$(uuidgen | tr -d - | cut -c1-24)
    ref_uuid=$(grep "REF_UUID_$file" /tmp/uuids.txt | cut -d= -f2)
    echo "				$build_uuid /* $file in Sources */," >> lua.xcodeproj/project.pbxproj
done

cat >> lua.xcodeproj/project.pbxproj << 'EOL'
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
				COPY_PHASE_STRIP = NO;
				GCC_OPTIMIZATION_LEVEL = 3;
				PRODUCT_NAME = lua;
				EXECUTABLE_PREFIX = lib;
				EXECUTABLE_EXTENSION = a;
				MACH_O_TYPE = staticlib;
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
				CLANG_ENABLE_MODULES = NO;
				DEAD_CODE_STRIPPING = YES;
				ONLY_ACTIVE_ARCH = NO;
				DEPLOYMENT_LOCATION = NO;
				STRIP_INSTALLED_PRODUCT = NO;
				GENERATE_MASTER_OBJECT_FILE = NO;
				LINK_WITH_STANDARD_LIBRARIES = YES;
				COMBINE_HIDPI_IMAGES = NO;
				LIBRARY_STYLE = STATIC;
				CONFIGURATION_BUILD_DIR = "$(SYMROOT)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)";
				TARGET_BUILD_DIR = "$(SYMROOT)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)";
				BUILT_PRODUCTS_DIR = "$(SYMROOT)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)";
				CONFIGURATION_TEMP_DIR = "$(SYMROOT)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)";
				SYMROOT = "$(SRCROOT)/build";
				OBJROOT = "$(SRCROOT)/build";
				INSTALL_PATH = "";
				PUBLIC_HEADERS_FOLDER_PATH = "include";
				DSTROOT = "$(SRCROOT)/build";
				SKIP_INSTALL = NO;
				COPY_PHASE_STRIP = NO;
				STRIP_STYLE = "non-global";
				STRIP_SWIFT_SYMBOLS = NO;
				PRESERVE_DEAD_CODE_INITS_AND_TERMS = YES;
				SEPARATE_STRIP = YES;
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
EOL

rm -f /tmp/uuids.txt

echo "Generated Xcode project at lua.xcodeproj"
echo "Source files included:"
echo "$SOURCE_FILES" 