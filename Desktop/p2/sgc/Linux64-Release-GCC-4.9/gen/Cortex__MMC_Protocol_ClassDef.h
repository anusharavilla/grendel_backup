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
 * Class definition for protocol Cortex__MMC_Protocol.
 */

#ifndef Cortex__MMC_Protocol_ClassDef_h_
#define Cortex__MMC_Protocol_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_MMC_Protocol.h"

namespace Cortex_NMS {

class Cortex__MMC_Protocol;

// Abstract interface implementation for port
class protocol_MMC_Protocol__Implementation: public protocol_MMC_Protocol
{
public:
    protocol_MMC_Protocol__Implementation(): thisPort(0) {}

    void SetPort(Cortex__MMC_Protocol *port) { thisPort = port; }

    // Protocol members
	inline mmc_resp_t cmd(mmc_cmd_t cmd, uint32_t arg, void* resp);
	inline bool Rx(const uint8_t* block, uint32_t len);
	inline void Rx_rdy();
	inline bool Tx(uint8_t* block, uint32_t len);
	inline void Tx_done();
	inline const char* cmd_name(mmc_cmd_t cmd);


private:
    // Parent port this interface belongs to.
    Cortex__MMC_Protocol *thisPort;
};


// Protocol (port) class definition
class Cortex__MMC_Protocol: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::SlaveConnector< mmc_resp_t (mmc_cmd_t,uint32_t,void*) > cmd;
	sg::MasterConnector< bool (const uint8_t*,uint32_t) > Rx;
	sg::SlaveConnector< void (void) > Rx_rdy;
	sg::MasterConnector< bool (uint8_t*,uint32_t) > Tx;
	sg::SlaveConnector< void (void) > Tx_done;
	sg::SlaveConnector< const char* (mmc_cmd_t) > cmd_name;


    Cortex__MMC_Protocol()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(cmd);
		define_behaviour(Rx);
		define_behaviour(Rx_rdy);
		define_behaviour(Tx);
		define_behaviour(Tx_done);
		define_behaviour(cmd_name);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_MMC_Protocol__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_MMC_Protocol *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline mmc_resp_t protocol_MMC_Protocol__Implementation::cmd(mmc_cmd_t cmd, uint32_t arg, void* resp)
{
	return thisPort->cmd(cmd, arg, resp);
}

inline bool protocol_MMC_Protocol__Implementation::Rx(const uint8_t* block, uint32_t len)
{
	return thisPort->Rx(block, len);
}

inline void protocol_MMC_Protocol__Implementation::Rx_rdy()
{
	return thisPort->Rx_rdy();
}

inline bool protocol_MMC_Protocol__Implementation::Tx(uint8_t* block, uint32_t len)
{
	return thisPort->Tx(block, len);
}

inline void protocol_MMC_Protocol__Implementation::Tx_done()
{
	return thisPort->Tx_done();
}

inline const char* protocol_MMC_Protocol__Implementation::cmd_name(mmc_cmd_t cmd)
{
	return thisPort->cmd_name(cmd);
}




// Mapping object
// (these ports are implemented inside Cortex__MMC_Protocol__AddressablePort)
class Cortex__MMC_Protocol__AddressablePort_OutPort: public Cortex__MMC_Protocol
{
public:
    // constructor
    Cortex__MMC_Protocol__AddressablePort_OutPort(uint32_t inFirst,
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
class Cortex__MMC_Protocol__AddressablePort: public Cortex__MMC_Protocol
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__MMC_Protocol__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__MMC_Protocol__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__MMC_Protocol__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__MMC_Protocol__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__MMC_Protocol__AddressablePort::isMapped__, this);

    }

    ~Cortex__MMC_Protocol__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__MMC_Protocol__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
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
        Cortex__MMC_Protocol__AddressablePort_OutPort *masterPort =
            new Cortex__MMC_Protocol__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->cmd.connectTo(&masterPort->cmd);
		this->Rx.connectTo(&masterPort->Rx);
		this->Rx_rdy.connectTo(&masterPort->Rx_rdy);
		this->Tx.connectTo(&masterPort->Tx);
		this->Tx_done.connectTo(&masterPort->Tx_done);
		this->cmd_name.connectTo(&masterPort->cmd_name);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__MMC_Protocol__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__MMC_Protocol__AddressablePort_OutPort*)port);
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
    typedef std::list<Cortex__MMC_Protocol__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__MMC_Protocol__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

