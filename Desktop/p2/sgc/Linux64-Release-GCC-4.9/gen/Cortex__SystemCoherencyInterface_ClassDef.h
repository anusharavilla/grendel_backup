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
 * Class definition for protocol Cortex__SystemCoherencyInterface.
 */

#ifndef Cortex__SystemCoherencyInterface_ClassDef_h_
#define Cortex__SystemCoherencyInterface_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_SystemCoherencyInterface.h"

namespace Cortex_NMS {

class Cortex__SystemCoherencyInterface;

// Abstract interface implementation for port
class protocol_SystemCoherencyInterface__Implementation: public protocol_SystemCoherencyInterface
{
public:
    protocol_SystemCoherencyInterface__Implementation(): thisPort(0) {}

    void SetPort(Cortex__SystemCoherencyInterface *port) { thisPort = port; }

    // Protocol members
	inline bool doDownstreamAction(const SystemCoherency::DownstreamAction& );
	inline bool doUpstreamAction(const SystemCoherency::UpstreamAction& );


private:
    // Parent port this interface belongs to.
    Cortex__SystemCoherencyInterface *thisPort;
};


// Protocol (port) class definition
class Cortex__SystemCoherencyInterface: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::SlaveConnector< bool (const SystemCoherency::DownstreamAction&) > doDownstreamAction;
	sg::MasterConnector< bool (const SystemCoherency::UpstreamAction&) > doUpstreamAction;


    Cortex__SystemCoherencyInterface()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(doDownstreamAction);
		define_behaviour(doUpstreamAction);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_SystemCoherencyInterface__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_SystemCoherencyInterface *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline bool protocol_SystemCoherencyInterface__Implementation::doDownstreamAction(const SystemCoherency::DownstreamAction& param0__)
{
	return thisPort->doDownstreamAction(param0__);
}

inline bool protocol_SystemCoherencyInterface__Implementation::doUpstreamAction(const SystemCoherency::UpstreamAction& param0__)
{
	return thisPort->doUpstreamAction(param0__);
}




// Mapping object
// (these ports are implemented inside Cortex__SystemCoherencyInterface__AddressablePort)
class Cortex__SystemCoherencyInterface__AddressablePort_OutPort: public Cortex__SystemCoherencyInterface
{
public:
    // constructor
    Cortex__SystemCoherencyInterface__AddressablePort_OutPort(uint32_t inFirst,
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
class Cortex__SystemCoherencyInterface__AddressablePort: public Cortex__SystemCoherencyInterface
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__SystemCoherencyInterface__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__SystemCoherencyInterface__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__SystemCoherencyInterface__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__SystemCoherencyInterface__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__SystemCoherencyInterface__AddressablePort::isMapped__, this);

    }

    ~Cortex__SystemCoherencyInterface__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__SystemCoherencyInterface__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
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
        Cortex__SystemCoherencyInterface__AddressablePort_OutPort *masterPort =
            new Cortex__SystemCoherencyInterface__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->doDownstreamAction.connectTo(&masterPort->doDownstreamAction);
		this->doUpstreamAction.connectTo(&masterPort->doUpstreamAction);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__SystemCoherencyInterface__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__SystemCoherencyInterface__AddressablePort_OutPort*)port);
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
    typedef std::list<Cortex__SystemCoherencyInterface__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__SystemCoherencyInterface__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

