# - Try to find precompiled headers support for GCC 3.4 and 4.x (and MSVC)
# Once done this will define:
#
# Variable:
#   PCHSupport_FOUND
#
#   ADD_PRECOMPILED_HEADER  _targetName _inputh _inputcpp
#   ADD_PRECOMPILED_HEADER_TO_TARGET _targetName _input _pch_output_to_use
#   ADD_NATIVE_PRECOMPILED_HEADER _targetName _inputh _inputcpp
# TODO: add support for clang

IF(CMAKE_COMPILER_IS_GNUCXX)

	EXEC_PROGRAM(
		${CMAKE_CXX_COMPILER}
		ARGS ${CMAKE_CXX_COMPILER_ARG1} -dumpversion
		OUTPUT_VARIABLE gcc_compiler_version)

	IF(gcc_compiler_version MATCHES "4\\.[0-9](\\.[0-9])?")
		SET(PCHSupport_FOUND TRUE)
	ELSE(gcc_compiler_version MATCHES "4\\.[0-9](\\.[0-9])?")
		IF(gcc_compiler_version MATCHES "3\\.4(\\.[0-9])?")
			SET(PCHSupport_FOUND TRUE)
		ELSE(gcc_compiler_version MATCHES "3\\.4(\\.[0-9])?")
			SET(PCHSupport_FOUND FALSE)
		ENDIF(gcc_compiler_version MATCHES "3\\.4(\\.[0-9])?")
	ENDIF(gcc_compiler_version MATCHES "4\\.[0-9](\\.[0-9])?")

	SET(_PCH_include_prefix "-I")

ELSE(CMAKE_COMPILER_IS_GNUCXX)

	IF(WIN32)
		SET(PCHSupport_FOUND TRUE) # for experimental msvc support
		SET(_PCH_include_prefix "/I")
	ELSE(WIN32)
		SET(PCHSupport_FOUND FALSE)
	ENDIF(WIN32)

ENDIF(CMAKE_COMPILER_IS_GNUCXX)

MACRO(_PCH_GET_COMPILE_FLAGS _out_compile_flags)

	STRING(TOUPPER "CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE}" _flags_var_name)
	SET(${_out_compile_flags} ${${_flags_var_name}} )

	IF(CMAKE_COMPILER_IS_GNUCXX)

		GET_TARGET_PROPERTY(_targetType ${_PCH_current_target} TYPE)
		IF((${_targetType} STREQUAL SHARED_LIBRARY) OR (${_targetType} STREQUAL MODULE_LIBRARY))
			LIST(APPEND ${_out_compile_flags} "-fPIC")
		ENDIF((${_targetType} STREQUAL SHARED_LIBRARY) OR (${_targetType} STREQUAL MODULE_LIBRARY))

	ELSE(CMAKE_COMPILER_IS_GNUCXX)
		## TODO ... ? or does it work out of the box
	ENDIF(CMAKE_COMPILER_IS_GNUCXX)

	GET_DIRECTORY_PROPERTY(DIRINC INCLUDE_DIRECTORIES )
	FOREACH(item ${DIRINC})
		LIST(APPEND ${_out_compile_flags} "${_PCH_include_prefix}${item}")
	ENDFOREACH(item)

	GET_DIRECTORY_PROPERTY(_directory_flags DEFINITIONS)
	GET_DIRECTORY_PROPERTY(_global_definitions DIRECTORY ${CMAKE_SOURCE_DIR} DEFINITIONS)
	LIST(APPEND ${_out_compile_flags} ${_directory_flags})
	LIST(APPEND ${_out_compile_flags} ${_global_definitions})
	LIST(APPEND ${_out_compile_flags} ${CMAKE_CXX_FLAGS})

	SEPARATE_ARGUMENTS(${_out_compile_flags})

ENDMACRO(_PCH_GET_COMPILE_FLAGS)

MACRO(_PCH_GET_COMPILE_COMMAND out_command _input _output)

	IF(CMAKE_COMPILER_IS_GNUCXX)
		IF(CMAKE_CXX_COMPILER_ARG1)
			# remove leading space in compiler argument
			STRING(REGEX REPLACE "^ +" "" pchsupport_compiler_cxx_arg1 ${CMAKE_CXX_COMPILER_ARG1})

			SET(${out_command}
				${CMAKE_CXX_COMPILER} ${pchsupport_compiler_cxx_arg1} ${_compile_FLAGS}	-x c++-header -o ${_output} -c ${_input}
				)
		ELSE(CMAKE_CXX_COMPILER_ARG1)
			SET(${out_command}
				${CMAKE_CXX_COMPILER} ${_compile_FLAGS} -x c++-header -o ${_output} -c ${_input}
				)
		ENDIF(CMAKE_CXX_COMPILER_ARG1)
	ELSE(CMAKE_COMPILER_IS_GNUCXX)

		# nothing to do because std*.cpp are already added to target

	ENDIF(CMAKE_COMPILER_IS_GNUCXX)

ENDMACRO(_PCH_GET_COMPILE_COMMAND )



MACRO(_PCH_GET_TARGET_COMPILE_FLAGS _cflags _header_name _pch_path)

	FILE(TO_NATIVE_PATH ${_pch_path} _native_pch_path)

	IF(CMAKE_COMPILER_IS_GNUCXX)
		# for use with distcc and gcc >4.0.1 if preprocessed files are accessible
		# on all remote machines set
		# PCH_ADDITIONAL_COMPILER_FLAGS to -fpch-preprocess
		SET(${_cflags} "${PCH_ADDITIONAL_COMPILER_FLAGS}-include ${CMAKE_CURRENT_BINARY_DIR}/${_header_name} -Winvalid-pch")
	ENDIF(CMAKE_COMPILER_IS_GNUCXX)

ENDMACRO(_PCH_GET_TARGET_COMPILE_FLAGS )

MACRO(GET_PRECOMPILED_HEADER_OUTPUT _targetName _input _output)
	GET_FILENAME_COMPONENT(_name ${_input} NAME)
	SET(_output "${CMAKE_CURRENT_BINARY_DIR}/${_name}.gch")
ENDMACRO(GET_PRECOMPILED_HEADER_OUTPUT _targetName _input)


MACRO(ADD_PRECOMPILED_HEADER_TO_TARGET _targetName _input _pch_output_to_use )

	# to do: test whether compiler flags match between target  _targetName
	# and _pch_output_to_use
	GET_FILENAME_COMPONENT(_name ${_input} NAME)

	_PCH_GET_TARGET_COMPILE_FLAGS(_target_cflags ${_name} ${_pch_output_to_use})

	SET_TARGET_PROPERTIES(${_targetName}
		PROPERTIES
		COMPILE_FLAGS ${_target_cflags}
	)

	ADD_CUSTOM_TARGET(pch_Generate_${_targetName}
		DEPENDS	${_pch_output_to_use}
	)

	ADD_DEPENDENCIES(${_targetName} pch_Generate_${_targetName} )

ENDMACRO(ADD_PRECOMPILED_HEADER_TO_TARGET)

MACRO(ADD_PRECOMPILED_HEADER _targetName _inputh _inputcpp)

	SET(_PCH_current_target ${_targetName})

	IF(NOT CMAKE_BUILD_TYPE)
		MESSAGE(FATAL_ERROR
			"This is the ADD_PRECOMPILED_HEADER macro. "
			"You must set CMAKE_BUILD_TYPE!"
		)
	ENDIF(NOT CMAKE_BUILD_TYPE)

	GET_PRECOMPILED_HEADER_OUTPUT( ${_targetName} ${_inputh} _output)

	GET_TARGET_PROPERTY(_targetType ${_PCH_current_target} TYPE)

	# always build static library because it doesn't need linking
	ADD_LIBRARY(${_targetName}_pch_dephelp STATIC ${_inputcpp})

	_PCH_GET_COMPILE_FLAGS(_compile_FLAGS)

	SET_SOURCE_FILES_PROPERTIES(${_inputh} PROPERTIES GENERATED 1)

	_PCH_GET_COMPILE_COMMAND(_command  ${_inputh} ${_output})

	ADD_CUSTOM_COMMAND(
		OUTPUT ${_output}
		COMMAND ${_command}
		DEPENDS ${_inputh} ${_targetName}_pch_dephelp
	)

	ADD_PRECOMPILED_HEADER_TO_TARGET(${_targetName} ${_inputh}  ${_output})

ENDMACRO(ADD_PRECOMPILED_HEADER)

MACRO(ADD_NATIVE_PRECOMPILED_HEADER _targetName _inputh _inputcpp)

	if(CMAKE_GENERATOR MATCHES Visual*)
		# Auto include the precompile (useful for moc processing, since the use of
		# precompiled is specified at the target level
		# and I don't want to specifiy /F- for each moc/res/ui generated files (using Qt)

		GET_TARGET_PROPERTY(oldProps ${_targetName} COMPILE_FLAGS)
		if (${oldProps} MATCHES NOTFOUND)
			SET(oldProps "")
		endif(${oldProps} MATCHES NOTFOUND)

		SET(newProperties "${oldProps} /Yu\"${_inputh}\" /FI\"${_inputh}\"")
		SET_TARGET_PROPERTIES(${_targetName} PROPERTIES COMPILE_FLAGS "${newProperties}")

		#also inlude ${oldProps} to have the same compile options
		SET_SOURCE_FILES_PROPERTIES(${_inputcpp} PROPERTIES COMPILE_FLAGS "${oldProps} /Yc\"${_inputh}\"")

	else(CMAKE_GENERATOR MATCHES Visual*)

		if (CMAKE_GENERATOR MATCHES Xcode)
			# For Xcode, cmake needs my patch to process
			# GCC_PREFIX_HEADER and GCC_PRECOMPILE_PREFIX_HEADER as target properties

			GET_TARGET_PROPERTY(oldProps ${_targetName} COMPILE_FLAGS)
			if (${oldProps} MATCHES NOTFOUND)
				SET(oldProps "")
			endif(${oldProps} MATCHES NOTFOUND)

			# When buiding out of the tree, precompiled may not be located
			# Use full path instead.
			GET_FILENAME_COMPONENT(fullPath ${_inputh} ABSOLUTE)

			SET_TARGET_PROPERTIES(${_targetName} PROPERTIES XCODE_ATTRIBUTE_GCC_PREFIX_HEADER "${fullPath}")
			SET_TARGET_PROPERTIES(${_targetName} PROPERTIES XCODE_ATTRIBUTE_GCC_PRECOMPILE_PREFIX_HEADER "YES")

		else (CMAKE_GENERATOR MATCHES Xcode)

			#Fallback to the "old" precompiled suppport
			ADD_PRECOMPILED_HEADER(${_targetName} ${_inputh} ${_inputcpp})
		endif(CMAKE_GENERATOR MATCHES Xcode)
	endif(CMAKE_GENERATOR MATCHES Visual*)

ENDMACRO(ADD_NATIVE_PRECOMPILED_HEADER)
