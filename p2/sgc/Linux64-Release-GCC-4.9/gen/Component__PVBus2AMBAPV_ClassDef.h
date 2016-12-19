/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2006 ARM Limited.
 * Copyright 2011 ARM LImited.
 *
 * All rights reserved.
 */

/** \file
 * Class definition for Component PVBus2AMBAPV.
 */

#ifndef Component_Component__PVBus2AMBAPV_ClassDef_h_
#define Component_Component__PVBus2AMBAPV_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <limits.h>
#include <map>
#include <fstream>
#include "SystemGenComponent.h"
#include "CADIBase.h"
#include "ComponentRegister.h"
#include "ResourceAccessFuncTypes.h"
#include "CADIParameterProxy.h"
#include "ParameterFilter.h"
#include "sg/SGTargetInfo.h"
#include "Cortex_DSO.h"

using namespace std;

#line 33 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
 

        /* WARNING! API not intended to be supported and will definitely
         * change in future releases. */
        #include <pv/PVMemoryAttributes.h>
        #include <pv/BusNode.h>
    
#line 44 "./Linux64-Release-GCC-4.9/gen/Component__PVBus2AMBAPV_ClassDef.h"
#include "Cortex__AMBAPV_ClassDef.h"
#include "Cortex__Builtin__ControlProtocol_ClassDef.h"
#include "Cortex__PVBus_ClassDef.h"
#include "Cortex__PVBusBridgeControl_ClassDef.h"
#include "Cortex__PVDevice_ClassDef.h"
#include "Cortex__Signal_ClassDef.h"



class SimulationEngine;
class ObjectLoader;

using namespace sg::accessfunc;

namespace eslapi
{
    class CADI;
}

namespace Cortex_NMS {

class ParameterFilter_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV : public ParameterFilter
{
public:
	ParameterFilter_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV()
	{
		ovrd_params["counters-file-name"] = eslapi::CADIParameterInfo_t(0x10000004 | PARAMETERFILTER_FORWARDED, "counters-file-name",eslapi::CADI_PARAM_STRING, "Prefix of the file name to store counters at the end of simulation",0,INT64_C(0x8000000000000000),INT64_C(0x7fffffffffffffff),INT64_C(0x0), "" ); // forwarded from "counters_file_name"
		ovrd_params["dmi-container-type"] = eslapi::CADIParameterInfo_t(0x10000003 | PARAMETERFILTER_FORWARDED, "dmi-container-type",eslapi::CADI_PARAM_STRING, "Type of the DMI cache. Allowed values: TZAttr and FullAttr",0,INT64_C(0x8000000000000000),INT64_C(0x7fffffffffffffff),INT64_C(0x0), "TZAttr" ); // forwarded from "dmi_container_type"
		ovrd_params["min-range-to-cache"] = eslapi::CADIParameterInfo_t(0x10000005 | PARAMETERFILTER_FORWARDED, "min-range-to-cache",eslapi::CADI_PARAM_INT, "Min DMI range size to cache in the bridge",0,INT64_C(0x1000),INT64_C(0x7fffffffffffffff),INT64_C(0x10000), "0x10000" ); // forwarded from "min_size_to_cache"
	}
};



class
#ifndef _WINDOWS
SG_Cortex_DSO
#endif
Component__PVBus2AMBAPV: public SystemGenComponent
{
public:
    // pointers to subcomponents
	sg::ComponentBase *bus_bridge;


    // control ports of subcomponents
	Cortex__Builtin__ControlProtocol controlPort_bus_bridge__;


    // abstract ports
	Cortex__PVBus pvbus_s;
	Cortex__Signal reset_bus_interfaces;
	Cortex__AMBAPV amba_pv_m;
	Cortex__PVBusBridgeControl control_bridge;
	Cortex__PVDevice device;


    // resources
    std::string application_pathname;


#line 41 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"


        // Limit size of memory region, defaulting to 48-bit
        const uint64_t  max_size   
                      ;

        const bool  force_dmi_size   
                      ;
        
        // Type of the DMI cache container. 
        // TZAttr -   A container which stores separately DMI ranges produced as a result of the NS attribute
        //            This is the default and a faster container
        // FullAttr - A container which stores separately DMI ranges produced as a result of transactions with different attributes
        //            FullAttr is only needed if any component downstream of the bridge would alter DMi ranges so that they differ
        //            based on ANY transaction attribute.
        //            This is the most strict container and as a result is the slowest one
        const std::string  dmi_container_type   
                      ;

        //The prefix provided here is going to be completed with the name of the instance of the bridge 
        //and an instance ID which is generated automatically. The file extension is .log
        const std::string  counters_file_name   
                      ;

        // Min DMI range size to cache. DMI ranges smaller than this will not by cached in the bridge
        // though they are still going to be used by the system
        // The smallest acceptable value here is 0x1000
        const uint32_t  min_size_to_cache   
                       ;

        static pv::bus_addr_t const LOG2_GRANULARITY = 12;
        static pv::bus_addr_t const GRANULARITY = 1 << LOG2_GRANULARITY;
        static pv::bus_addr_t const GRANULARITY_MASK = GRANULARITY - 1;

        inline pv::bus_addr_t getBaseAddress(pv::bus_addr_t address) const
        {
            return force_dmi_size ?
                address & ~GRANULARITY_MASK :
                address;
        }

        inline pv::bus_addr_t getLimitAddress(pv::bus_addr_t address) const
        {
            pv::bus_addr_t limit = force_dmi_size ?
                                    (address | GRANULARITY_MASK):
                                    address;

            // Limit address range to 'max_size'
            if ((max_size > 0) && (limit > max_size))
               limit = max_size;
            return limit;
        }
        
        amba_pv::amba_pv_trans_pool trans_pool;

        amba_pv::amba_pv_trans_ptr transCacheRead;
        amba_pv::amba_pv_trans_ptr transCacheWrite;

        pv::BridgeBusNode  bus_node;
    
#line 167 "./Linux64-Release-GCC-4.9/gen/Component__PVBus2AMBAPV_ClassDef.h"


    // find parameter name for a specific CADIFactory parameter ID
    std::map<uint32_t,std::string> parameterId2parameterName__;

    // list of all CADI parameters
    std::vector<eslapi::CADIParameterInfo_t> parameterInfos__;


    // ================================================================================
    // methods
    // ================================================================================

    // constructor and destructor
    Component__PVBus2AMBAPV(const char *argv, sg::SimulationContext* simulationContext, const sg::Params & params);
    ~Component__PVBus2AMBAPV();

    // interface functions
    sg::SimulationContext* getSimulationContext() const { return simulationContext__; }

    // control port implementation
    void control_port__configure(const sg::Params& params);
    void control_port__loadApplicationFile(const std::string& filename);
    void control_port__serializeState(const char *name, cp::SerializationInterface* stream);
    std::string control_port__getProperty(const std::string& propname);
    std::string control_port__bypass(const std::string&);
    void control_port__run();
    void control_port__stop();
    void control_port__idle();
    void control_port__quit();
    void control_port__getMxDI(std::map<std::string,eslapi::CADI*>*);
    void control_port__setSimulationEngine(SimulationEngine*);
    void control_port__populateCADIMap(std::map< std::string, eslapi::CAInterface* > &, std::string const &);
    void control_port__message(const std::string &msg, sg::message::MessageType msgType);
    std::string control_port__callSimEngine(const std::string&);
    void control_port__reset(int level);
    void control_port__terminate();

    // CADI Port implementations
    eslapi::CADIReturn_t cadiPort__GetParameters(uint32_t startIndex, uint32_t desiredNumOfParams, uint32_t *actualNumOfParams, eslapi::CADIParameterInfo_t *params);
    eslapi::CADIReturn_t cadiPort__GetParameterInfo(const std::string &parameterName, eslapi::CADIParameterInfo_t* param);
    eslapi::CADIReturn_t cadiPort__GetParameterValues (uint32_t parameterCount, uint32_t *actualNumOfParamsRead, eslapi::CADIParameterValue_t *paramValuesOut);
    eslapi::CADIReturn_t cadiPort__SetParameters(uint32_t count, eslapi::CADIParameterValue_t *params, eslapi::CADIFactoryErrorMessage_t *error);
    eslapi::CADIReturn_t cadiPort__GetProperty(const std::string& propertyName, std::string &value);
    void cadiPort__LoadApplicationFile(const std::string& filename);
    void cadiPort__GetApplicationsAndCommandLineParams(std::map<std::string, std::string>&applications2params_);

    // helper functions
    void insertCADIMap__(std::string prefix, std::map< std::string, eslapi::CAInterface*>&componentName2CADI);

    sg::accessfunc::AccessFuncResult parameter_read_func(uint32_t id, int64_t *data);
    sg::accessfunc::AccessFuncResult parameter_read_string_func(uint32_t id, std::string &data);
    sg::accessfunc::AccessFuncResult parameter_write_func(uint32_t id, const int64_t *data);
    sg::accessfunc::AccessFuncResult parameter_write_string_func(uint32_t id, const std::string &data);

    sg::accessfunc::AccessFuncResult GetExtendedTargetFeatures__(uint32_t /*id*/, std::string &data, bool /*se*/);

    // dummy functions, mostly required by IsimMain (formerly InterpreterMain), will go away soon

    // May be required by TraceGen however that itself is obsolete
    uint64_t getInstructionCount() const { return 0; }
    // May be required by SystemGen however that itself is obsolete
    uint64_t getCycleCount() const { return 0; }

	void build_amba_pv_extension(const pv::Transaction* tx, amba_pv::amba_pv_extension* ex);
	bool send_tlm_dmi_request(pv::Transaction* tx, tlm::tlm_command command);
	pv::Tx_Result handle_transaction_result(pv::Transaction* tx, amba_pv::amba_pv_transaction* trans, amba_pv::amba_pv_extension* extension);
	pv::Tx_Result send_tlm_transaction(pv::Transaction* tx, tlm::tlm_command command, amba_pv::amba_pv_transaction* transCache);
	pv::Tx_Result send_tlm_transaction(pv::Transaction* tx, tlm::tlm_command command, bool debug);
	bool get_direct_mem_ptr(pv::Transaction* tx, amba_pv::amba_pv_transaction& trans);
	void init();
	void terminate();
	void reset(int level_);
	void busDiscovery();
	void interconnect();
	void disconnect();
	void loadApplicationFile(const std::string& filename);
	void step();
	void abstract_port__amba_pv_m__invalidate_direct_mem_ptr(int socket_id, sc_dt::uint64 start_range, sc_dt::uint64 end_range);
	pv::Tx_Result abstract_port__device__read(pv::ReadTransaction tx);
	pv::Tx_Result abstract_port__device__write(pv::WriteTransaction tx);
	pv::Tx_Result abstract_port__device__debugRead(pv::ReadTransaction tx);
	pv::Tx_Result abstract_port__device__debugWrite(pv::WriteTransaction tx);

    void simHalt();
    void simRun();
    bool simIsRunning();
    void simShutdown();
    void simReset(uint32_t level);


private:
    // methods
    eslapi::CADI* obtainCADI__(const std::string &subcomp, const std::map< std::string, eslapi::CAInterface* > &componentName2CADI) const;
    static bool ForwardParameterValueToSubcomponent(CADIParameterProxy *proxy,
                                                    const char *param_name,
                                                    int64_t intVal,
                                                    const char *strVal);
    uint32_t paramNameToParamAccessFuncID(const std::string &name);
    void buildDebugInfoWithMetaData__();

    void reset_resources__();
    void freeCADIResources__();
    void connect_controlports__();
    void add_abstractports__();
    void wire_connectionmap__();

    	void add_abstractports__0__();

    	void wire_connectionmap__0__();



	ParameterFilter_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV parameterFilter_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV__;


	CADIParameterProxy *cadiParameterProxy_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV__;


    // definition of parameter IDs as constants for use in parameter access functions
	enum
	{
		PARAMETER_ID_max_size = 0x10000001,
		PARAMETER_ID_force_dmi_size = 0x10000002,
		PARAMETER_ID_dmi_container_type = 0x10000003,
		PARAMETER_ID_counters_file_name = 0x10000004,
		PARAMETER_ID_min_size_to_cache = 0x10000005,
	};




};

} // namespace Cortex_NMS

#endif

