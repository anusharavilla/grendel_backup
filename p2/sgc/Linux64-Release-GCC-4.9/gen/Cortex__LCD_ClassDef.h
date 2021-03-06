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
 * Class definition for protocol Cortex__LCD.
 */

#ifndef Cortex__LCD_ClassDef_h_
#define Cortex__LCD_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_LCD.h"

namespace Cortex_NMS {

class Cortex__LCD;

// Abstract interface implementation for port
class protocol_LCD__Implementation: public protocol_LCD
{
public:
    protocol_LCD__Implementation(): thisPort(0) {}

    void SetPort(Cortex__LCD *port) { thisPort = port; }

    // Protocol members
	inline const VisRasterLayout* lock();
	inline void unlock();
	inline void update(int x, int y, unsigned int w, unsigned int h);
	inline void setPreferredLayout(unsigned int width, unsigned int height, unsigned int depth);


private:
    // Parent port this interface belongs to.
    Cortex__LCD *thisPort;
};


// Protocol (port) class definition
class Cortex__LCD: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::SlaveConnector< const VisRasterLayout* (void) > lock;
	sg::SlaveConnector< void (void) > unlock;
	sg::SlaveConnector< void (int,int,unsigned int,unsigned int) > update;
	sg::SlaveConnector< void (unsigned int,unsigned int,unsigned int) > setPreferredLayout;


    Cortex__LCD()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(lock);
		define_behaviour(unlock);
		define_behaviour(update);
		define_behaviour(setPreferredLayout);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_LCD__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_LCD *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline const VisRasterLayout* protocol_LCD__Implementation::lock()
{
	return thisPort->lock();
}

inline void protocol_LCD__Implementation::unlock()
{
	return thisPort->unlock();
}

inline void protocol_LCD__Implementation::update(int x, int y, unsigned int w, unsigned int h)
{
	return thisPort->update(x, y, w, h);
}

inline void protocol_LCD__Implementation::setPreferredLayout(unsigned int width, unsigned int height, unsigned int depth)
{
	return thisPort->setPreferredLayout(width, height, depth);
}




// Mapping object
// (these ports are implemented inside Cortex__LCD__AddressablePort)
class Cortex__LCD__AddressablePort_OutPort: public Cortex__LCD
{
public:
    // constructor
    Cortex__LCD__AddressablePort_OutPort(uint32_t inFirst,
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
class Cortex__LCD__AddressablePort: public Cortex__LCD
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__LCD__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__LCD__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__LCD__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__LCD__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__LCD__AddressablePort::isMapped__, this);

    }

    ~Cortex__LCD__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__LCD__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
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
        Cortex__LCD__AddressablePort_OutPort *masterPort =
            new Cortex__LCD__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->lock.connectTo(&masterPort->lock);
		this->unlock.connectTo(&masterPort->unlock);
		this->update.connectTo(&masterPort->update);
		this->setPreferredLayout.connectTo(&masterPort->setPreferredLayout);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__LCD__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__LCD__AddressablePort_OutPort*)port);
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
    typedef std::list<Cortex__LCD__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__LCD__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

