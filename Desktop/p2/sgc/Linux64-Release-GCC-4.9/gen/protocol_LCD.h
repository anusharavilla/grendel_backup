/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2007 ARM Limited.
 * Copyright 2011 ARM Limited.
 *
 * All rights reserved.
 */

/** \file
 * Abstract interface class protocol_LCD for protocol LCD.
 */

#ifndef protocol_LCD_h_
#define protocol_LCD_h_

// Includes from the 'includes' section of this protocol
#line 11 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/LCDPort.lisa"

        #include "components/Visualisation.h"
    
#line 25 "./Linux64-Release-GCC-4.9/gen/protocol_LCD.h"


// Abstract interface for protocol LCD
class protocol_LCD
{
public:
        virtual ~protocol_LCD() {}
        // Abstract protocol members
	virtual const VisRasterLayout* lock() = 0;
	virtual void unlock() = 0;
	virtual void update(int x, int y, unsigned int w, unsigned int h) = 0;
	virtual void setPreferredLayout(unsigned int width, unsigned int height, unsigned int depth) = 0;

};

#endif /* protocol_LCD_h_ */

