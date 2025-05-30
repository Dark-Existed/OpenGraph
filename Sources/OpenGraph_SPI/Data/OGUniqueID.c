//
//  OGUniqueID.c
//  OpenGraph_SPI
//
//  Audited for iOS 18.0
//  Status: Complete

#include "OGUniqueID.h"
#include <stdatomic.h>

OGUniqueID OGMakeUniqueID(void) {
    // Initial value is 1
    static atomic_long counter = 1;
    return counter++;
}
