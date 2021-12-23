# Install script for directory: /mnt/HDD/xxl/SLM-DB

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libleveldb.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE STATIC_LIBRARY FILES "/mnt/HDD/xxl/SLM-DB/build/libleveldb.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/leveldb/c.h;/usr/local/include/leveldb/cache.h;/usr/local/include/leveldb/comparator.h;/usr/local/include/leveldb/db.h;/usr/local/include/leveldb/dumpfile.h;/usr/local/include/leveldb/env.h;/usr/local/include/leveldb/iterator.h;/usr/local/include/leveldb/filter_policy.h;/usr/local/include/leveldb/iterator.h;/usr/local/include/leveldb/options.h;/usr/local/include/leveldb/slice.h;/usr/local/include/leveldb/status.h;/usr/local/include/leveldb/table.h;/usr/local/include/leveldb/table_builder.h;/usr/local/include/leveldb/write_batch.h;/usr/local/include/leveldb/export.h;/usr/local/include/leveldb/persistant_pool.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/leveldb" TYPE FILE FILES
    "/mnt/HDD/xxl/SLM-DB/include/leveldb/c.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/cache.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/comparator.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/db.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/dumpfile.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/env.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/iterator.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/filter_policy.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/iterator.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/options.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/slice.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/status.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/table.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/table_builder.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/write_batch.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/export.h"
    "/mnt/HDD/xxl/SLM-DB/
        include/leveldb/index.h
        include/leveldb/persistant_pool.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/mnt/HDD/xxl/SLM-DB/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
