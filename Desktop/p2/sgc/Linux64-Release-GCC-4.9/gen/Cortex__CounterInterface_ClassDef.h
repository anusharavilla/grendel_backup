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
 * Class definition for protocol Cortex__CounterInterface.
 */

#ifndef Cortex__CounterInterface_ClassDef_h_
#define Cortex__CounterInterface_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_CounterInterface.h"

namespace Cortex_NMS {

class Cortex__CounterInterface;

// Abstract interface implementation for port
class protocol_CounterInterface__Implementation: public protocol_CounterInterface
{
public:
    protocol_CounterInterface__Implementation(): thisPort(0) {}

    void SetPort(Cortex__CounterInterface *port) { thisPort = port; }

    // Protocol members
	inline uint64_t getCounterValue();
	inline void requestSignalUpdate(uint64_t at);
	inline void signalUpdate();
	inline void setEnabled(bool );
	inline void requestEventUpdate(uint64_t at);
	inline void eventUpdate();


private:
    // Parent port this interface belongs to.
    Cortex__CounterInterface *thisPort;
};


// Protocol (port) class definition
class Cortex__CounterInterface: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::MasterConnector< uint64_t (void) > getCounterValue;
	sg::MasterConnector< void (uint64_t) > requestSignalUpdate;
	sg::SlaveConnector< void (void) > signalUpdate;
	sg::SlaveConnector< void (bool) > setEnabled;
	sg::MasterConnector< void (uint64_t) > requestEventUpdate;
	sg::SlaveConnector< void (void) > eventUpdate;


    Cortex__CounterInterface()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(getCounterValue);
		define_behaviour(requestSignalUpdate);
		define_behaviour(signalUpdate);
		define_behaviour(setEnabled);
		define_behaviour(requestEventUpdate);
		define_behaviour(eventUpdate);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_CounterInterface__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_CounterInterface *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline uint64_t protocol_CounterInterface__Implementation::getCounterValue()
{
	return thisPort->getCounterValue();
}

inline void protocol_CounterInterface__Implementation::requestSignalUpdate(uint64_t at)
{
	return thisPort->requestSignalUpdate(at);
}

inline void protocol_CounterInterface__Implementation::signalUpdate()
{
	return thisPort->signalUpdate();
}

inline void protocol_CounterInterface__Implementation::setEnabled(bool param0__)
{
	return thisPort->setEnabled(param0__);
}

inline void protocol_CounterInterface__Implementation::requestEventUpdate(uint64_t at)
{
	return thisPort->requestEventUpdate(at);
}

inline void protocol_CounterInterface__Implementation::eventUpdate()
{
	return thisPort->eventUpdate();
}




// Mapping object
// (these ports are implemented inside Cortex__CounterInterface__AddressablePort)
class Cortex__CounterInterface__AddressablePort_OutPort: public Cortex__CounterInterface
{
public:
    // constructor
    Cortex__CounterInterface__AddressablePort_OutPort(uint32_t inFirst,
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
class Cortex__CounterInterface__AddressablePort: public Cortex__CounterInterface
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__CounterInterface__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__CounterInterface__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__CounterInterface__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__CounterInterface__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__CounterInterface__AddressablePort::isMapped__, this);

    }

    ~Cortex__CounterInterface__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__CounterInterface__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
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
        Cortex__CounterInterface__AddressablePort_OutPort *masterPort =
            new Cortex__CounterInterface__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->getCounterValue.connectTo(&masterPort->getCounterValue);
		this->requestSignalUpdate.connectTo(&masterPort->requestSignalUpdate);
		this->signalUpdate.connectTo(&masterPort->signalUpdate);
		this->setEnabled.connectTo(&masterPort->setEnabled);
		this->requestEventUpdate.connectTo(&masterPort->requestEventUpdate);
		this->eventUpdate.connectTo(&masterPort->eventUpdate);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__CounterInterface__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__CounterInterface__AddressablePort_OutPort*)port);
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
    typedef std::list<Cortex__CounterInterface__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__CounterInterface__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

