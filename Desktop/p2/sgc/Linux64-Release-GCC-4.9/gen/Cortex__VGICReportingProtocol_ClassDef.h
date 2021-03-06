/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2005 ARM Limited.
 * Copyright 2011 ARM Limited.
 *
 * All rights reserved.
 */

/** \file
 * Class definition for protocol Cortex__VGICReportingProtocol.
 */

#ifndef Cortex__VGICReportingProtocol_ClassDef_h_
#define Cortex__VGICReportingProtocol_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_VGICReportingProtocol.h"

namespace Cortex_NMS {

class Cortex__VGICReportingProtocol;

// Abstract interface implementation for port
class protocol_VGICReportingProtocol__Implementation: public protocol_VGICReportingProtocol
{
public:
    protocol_VGICReportingProtocol__Implementation(): thisPort(0) {}

    void SetPort(Cortex__VGICReportingProtocol *port) { thisPort = port; }

    // Protocol members
	inline void logWarnings(const char* buffer_);
	inline void logErrors(const char* buffer_);
	inline void logFatal(const char* buffer_);
	inline uint32_t setEnables(uint32_t new_enable_);


private:
    // Parent port this interface belongs to.
    Cortex__VGICReportingProtocol *thisPort;
};


// Protocol (port) class definition
class Cortex__VGICReportingProtocol: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::SlaveConnector< void (const char*) > logWarnings;
	sg::SlaveConnector< void (const char*) > logErrors;
	sg::SlaveConnector< void (const char*) > logFatal;
	sg::MasterConnector< uint32_t (uint32_t) > setEnables;


    Cortex__VGICReportingProtocol()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(logWarnings);
		define_behaviour(logErrors);
		define_behaviour(logFatal);
		define_behaviour(setEnables);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_VGICReportingProtocol__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_VGICReportingProtocol *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline void protocol_VGICReportingProtocol__Implementation::logWarnings(const char* buffer_)
{
	return thisPort->logWarnings(buffer_);
}

inline void protocol_VGICReportingProtocol__Implementation::logErrors(const char* buffer_)
{
	return thisPort->logErrors(buffer_);
}

inline void protocol_VGICReportingProtocol__Implementation::logFatal(const char* buffer_)
{
	return thisPort->logFatal(buffer_);
}

inline uint32_t protocol_VGICReportingProtocol__Implementation::setEnables(uint32_t new_enable_)
{
	return thisPort->setEnables(new_enable_);
}




// Mapping object
// (these ports are implemented inside Cortex__VGICReportingProtocol__AddressablePort)
class Cortex__VGICReportingProtocol__AddressablePort_OutPort: public Cortex__VGICReportingProtocol
{
public:
    // constructor
    Cortex__VGICReportingProtocol__AddressablePort_OutPort(uint32_t inFirst,
                                                 uint32_t inLast,
                                                 uint32_t outFirst,
                                                 uint32_t outLast):
    inFirst__(inFirst),
    inLast__(inLast),
    outFirst__(outFirst),
    outSize__(outLast - outFirst + 1)
    {
    }

    bool isCovered__(uint32_t address) const
    {
        return (address >= inFirst__) && (address <= inLast__);
    }

    void remapAddress__(uint32_t &address) const
    {
        if(outSize__)
            address = ((address - inFirst__) % outSize__) + outFirst__;
    }

private:
    uint32_t inFirst__;
    uint32_t inLast__;
    uint32_t outFirst__;
    uint32_t outSize__;
};


// Addressable protocol class definition
class Cortex__VGICReportingProtocol__AddressablePort: public Cortex__VGICReportingProtocol
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__VGICReportingProtocol__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__VGICReportingProtocol__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__VGICReportingProtocol__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__VGICReportingProtocol__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__VGICReportingProtocol__AddressablePort::isMapped__, this);

    }

    ~Cortex__VGICReportingProtocol__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__VGICReportingProtocol__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
        {
            if ((*it)->isCovered__(addr)) {
                (*it)->remapAddress__(addr);
                return *it;
            }
        }
        return defaultOutPort__;
    }

    sg::Port* mapRange__(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast)
    {
        Cortex__VGICReportingProtocol__AddressablePort_OutPort *masterPort =
            new Cortex__VGICReportingProtocol__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->logWarnings.connectTo(&masterPort->logWarnings);
		this->logErrors.connectTo(&masterPort->logErrors);
		this->logFatal.connectTo(&masterPort->logFatal);
		this->setEnables.connectTo(&masterPort->setEnables);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__VGICReportingProtocol__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__VGICReportingProtocol__AddressablePort_OutPort*)port);
        if(defaultOutPort__ == port)
        {
            delete defaultOutPort__;
            defaultOutPort__ = 0;
        }
    }

    bool isMapped__(uint64_t addr)
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
        {
            if ((*it)->isCovered__(static_cast<uint32_t>(addr)))
                return true;
        }
        return false;
    }

    // Wrapper functions for protocol behaviors


private:
    typedef std::list<Cortex__VGICReportingProtocol__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__VGICReportingProtocol__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

