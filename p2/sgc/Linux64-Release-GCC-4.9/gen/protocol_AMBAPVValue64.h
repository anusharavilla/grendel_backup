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
 * Abstract interface class protocol_AMBAPVValue64 for protocol AMBAPVValue64.
 */

#ifndef protocol_AMBAPVValue64_h_
#define protocol_AMBAPVValue64_h_

// Includes from the 'includes' section of this protocol
#line 29 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/AMBAPVValue64Protocol.lisa"

        #include <amba_pv.h>
        #include <sg/SGstdint.h>
    
#line 26 "./Linux64-Release-GCC-4.9/gen/protocol_AMBAPVValue64.h"


// Abstract interface for protocol AMBAPVValue64
class protocol_AMBAPVValue64
{
public:
        virtual ~protocol_AMBAPVValue64() {}
        // Abstract protocol members
	virtual void set_state(int export_id, const uint64_t& value) = 0;

};

#endif /* protocol_AMBAPVValue64_h_ */

