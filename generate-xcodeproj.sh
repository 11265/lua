#!/bin/bash
set -e

# Create Xcode project directory
mkdir -p lua.xcodeproj

# Generate source file list
SOURCE_FILES=$(ls *.c | grep -v 'lua\.c\|onelua\.c\|ltests\.c')
echo "Source files to be included: $SOURCE_FILES"

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
    echo "BUILD_UUID_$file=$build_uuid" >> /tmp/uuids.txt
    echo "REF_UUID_$file=$ref_uuid" >> /tmp/uuids.txt
done
echo "/* End PBXBuildFile section */" >> lua.xcodeproj/project.pbxproj

# PBXFileReference section
echo "/* Begin PBXFileReference section */" >> lua.xcodeproj/project.pbxproj
for file in $SOURCE_FILES; do
    ref_uuid=$(grep "REF_UUID_$file" /tmp/uuids.txt | cut -d= -f2)
    echo "		$ref_uuid /* $file */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.c; name = $file; path = $file; sourceTree = \"<group>\"; };" >> lua.xcodeproj/project.pbxproj
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
			name = lua;
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
			name = Sources;
			sourceTree = "<group>";
		};
		19C28FACFE9D520D11CA2CBB /* Products */ = {
			isa = PBXGroup;
			children = (
				8D1107320486CEB800E47090 /* liblua.a */,
			);
			name = Products;
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
			attributes = {
				LastUpgradeCheck = 1420;
			};
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
    build_uuid=$(grep "BUILD_UUID_$file" /tmp/uuids.txt | cut -d= -f2)
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
				'PRODUCT_NAME' => 'lua',
				'PRODUCT_BUNDLE_IDENTIFIER' => 'com.example.lua',
				'SKIP_INSTALL' => 'NO',
				'DEPLOYMENT_LOCATION' => 'NO',
				'INSTALL_PATH' => '',
				'PUBLIC_HEADERS_FOLDER_PATH' => 'include/lua',
				'SUPPORTED_PLATFORMS' => 'iphoneos iphonesimulator',
				'TARGETED_DEVICE_FAMILY' => '1,2',
				'IPHONEOS_DEPLOYMENT_TARGET' => '12.0',
				'SDKROOT' => 'iphoneos',
				'GCC_OPTIMIZATION_LEVEL' => '3',
				'HEADER_SEARCH_PATHS' => ['$(SRCROOT)/src'],
				'CLANG_ENABLE_OBJC_ARC' => 'YES',
				'ENABLE_BITCODE' => 'NO',
				'ONLY_ACTIVE_ARCH' => 'NO',
				'VALID_ARCHS' => 'arm64 x86_64',
				'ARCHS' => '$(ARCHS_STANDARD)',
				'CODE_SIGN_STYLE' => 'Manual',
				'CODE_SIGNING_REQUIRED' => 'NO',
				'CODE_SIGN_IDENTITY' => '',
				'DEVELOPMENT_TEAM' => '',
				'PROVISIONING_PROFILE_SPECIFIER' => '',
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