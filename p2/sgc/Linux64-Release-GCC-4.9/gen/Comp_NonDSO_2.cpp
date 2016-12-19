/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2009 ARM Limited.
 * Copyright 2011 ARM Limited.
 *
 * All rights reserved.
 */
/** \file
 * System components.
 */

#include "GlobalDefs.h"
#include "Components.h"

#include "Component__PVBus2AMBAPV_ClassDef.h"


#include "eslapi/CADITypes.h"

#include "cp/SerializationInterface.h"


#include "sg/SGBasicComponentFactory.h"
#include "sg/FastDelegate.h"

#include "TerminateScheduler.h"
#include "ParameterFilter.h"

#include <sg/MSCFixes.h>

// make the MSG_<...> symbols available in the global namespace
using namespace sg::message;
using namespace fastdelegate;

// component CADI interfaces
// ------------------------------------------------------------------------------
// CADI Interface for component Component__PVBus2AMBAPV
// ------------------------------------------------------------------------------

namespace Cortex_NMS {

class Component__PVBus2AMBAPV_CADI : public sg::CADIBase
{
public:
        Component__PVBus2AMBAPV_CADI(Component__PVBus2AMBAPV* parentComponent, sg::ComponentBase* simulationEngine);

    eslapi::CADIReturn_t CADIXfaceBypass(uint32_t commandLength, const char *command, uint32_t maxResponseLength, char *response);

private:
    Component__PVBus2AMBAPV *component;
};

} // Cortex_NMS


// non inline behaviors
#line 204 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::build_amba_pv_extension(const pv::Transaction* tx, amba_pv::amba_pv_extension* ex)
{
 const pv::TransactionAttributes* attr = tx->getAttributes();
 if (attr != 0)
 {
 ex->set_id(attr->getMasterID());

 
 
 
 
 
 
 

 
 ex->set_bufferable(attr->isOuterBufferable());
 ex->set_modifiable(attr->isOuterCacheable());
 ex->set_read_allocate(attr->isOuterReadAllocatable());
 ex->set_write_allocate(attr->isOuterWriteAllocatable());

 
 ex->set_privileged(attr->isPrivileged());
 ex->set_non_secure(attr->isNormalWorld());
 ex->set_instruction(attr->isInstruction());

 
 ex->set_exclusive(attr->isExclusive());
 ex->set_locked(attr->isLocked()); 

 
 ex->set_user(attr->getUserFlags());
 }
 
}
}

#line 242 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { bool 
Component__PVBus2AMBAPV::send_tlm_dmi_request(pv::Transaction* tx, tlm::tlm_command command)
{
 amba_pv::amba_pv_trans_ptr trans(trans_pool.allocate(1, NULL));
 amba_pv::amba_pv_extension * ex = NULL;

 
 trans->set_command(command);
 trans->set_address(tx->getAddress());

 
 trans->get_extension(ex);
 build_amba_pv_extension(tx, ex);

 
 return get_direct_mem_ptr(tx, *trans);
 
}
}

#line 261 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { pv::Tx_Result 
Component__PVBus2AMBAPV::handle_transaction_result(pv::Transaction* tx, amba_pv::amba_pv_transaction* trans, amba_pv::amba_pv_extension* extension)
{
 bool dmi_allowed = false;
 amba_pv::amba_pv_resp_t amba_resp;
 bool amba_exclusive = false;

 dmi_allowed = trans->is_dmi_allowed();
 amba_resp = extension->get_resp();
 amba_exclusive = extension->is_exclusive();

 if (dmi_allowed)
 {
 if (tx->getPayload()->getWantPrefetch())
 {
 assert(amba_exclusive == false); 
 trans->set_address(tx->getAddress());
 extension->set_id(tx->getMasterID());
 get_direct_mem_ptr(tx, *trans);
 }
 else
 {
 if (trans->is_read())
 tx->getPayload()->setPrefetchReadHint(); 
 else
 tx->getPayload()->setPrefetchWriteHint(); 
 }
 }

 
 switch(amba_resp)
 {
 case amba_pv::AMBA_PV_INCOMPLETE: return tx->generateAbort();
 case amba_pv::AMBA_PV_SLVERR: return tx->generateSlaveAbort();
 case amba_pv::AMBA_PV_DECERR: return tx->generateDecodeAbort();
 case amba_pv::AMBA_PV_OKAY:
 if (amba_exclusive)
 return tx->generateExclusiveAbort();
 break;
 case amba_pv::AMBA_PV_EXOKAY:
 break;
 }

 return pv::Tx_Result();
 
}
}

#line 310 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { pv::Tx_Result 
Component__PVBus2AMBAPV::send_tlm_transaction(pv::Transaction* tx, tlm::tlm_command command, amba_pv::amba_pv_transaction* transCache)
{
 pv::Tx_Result res;
 static unsigned reentCouner = 0;

 if (reentCouner > 0)
 return send_tlm_transaction(tx, command, false);

 {
 ++reentCouner;

 
 transCache->set_response_status(tlm::TLM_INCOMPLETE_RESPONSE);
 transCache->set_dmi_allowed(false);
 transCache->set_address(tx->getAddress());
 transCache->set_data_ptr((unsigned char*)tx->referenceDataValue());
 transCache->set_data_length(tx->getTransactionByteSize());
 transCache->set_streaming_width(transCache->get_data_length()); 

 
 amba_pv::amba_pv_extension *extensionCache;
 transCache->get_extension(extensionCache);
 build_amba_pv_extension(tx, extensionCache);
 
 extensionCache->set_size(tx->getAccessByteWidth());
 extensionCache->set_length(tx->getBurstLength());

 
 
 
 
 
 
 sc_core::sc_time t(double(tx->getLocalTimeInTicks()) * sc_core::sc_get_time_resolution().to_seconds(), sc_core::SC_SEC);
 
 amba_pv_m.b_transport(0, *transCache, t);
 tx->setLocalTimeInTicks(t.value());

 res = handle_transaction_result(tx, transCache, extensionCache);

 transCache->reset();
 
 --reentCouner;
 }

 return res;
 
}
}

#line 361 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { pv::Tx_Result 
Component__PVBus2AMBAPV::send_tlm_transaction(pv::Transaction* tx, tlm::tlm_command command, bool debug)
{
 amba_pv::amba_pv_trans_ptr trans(trans_pool.allocate(tx->getBurstLength(),
 tx->getAccessByteWidth(),
 NULL,
 amba_pv::AMBA_PV_INCR));
 amba_pv::amba_pv_extension * ex = NULL;
 pv::Tx_Result result;

 
 trans->set_command(command);
 trans->set_address(tx->getAddress());
 trans->set_data_ptr((unsigned char*)tx->referenceDataValue());
 trans->set_data_length(tx->getTransactionByteSize());
 trans->set_streaming_width(trans->get_data_length()); 

 
 trans->get_extension(ex);
 build_amba_pv_extension(tx, ex);

 if (debug)
 {
 if (amba_pv_m.transport_dbg(0, *trans) != trans->get_data_length())
 {
 result = tx->generateAbort();
 }
 }
 else
 {
 
 
 
 
 
 sc_core::sc_time t(double(tx->getLocalTimeInTicks()) * sc_core::sc_get_time_resolution().to_seconds(), sc_core::SC_SEC);
 

 amba_pv_m.b_transport(0, *trans, t);
 tx->setLocalTimeInTicks(t.value());
 }

 
 if (debug)
 return result;

 result = handle_transaction_result(tx, trans.get(), ex);

 return result;
 
}
}

#line 412 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { bool 
Component__PVBus2AMBAPV::get_direct_mem_ptr(pv::Transaction* tx, amba_pv::amba_pv_transaction& trans)
{
 tlm::tlm_dmi dmi_data;
 bool dmi_ok = amba_pv_m.get_direct_mem_ptr(0, trans, dmi_data);
 sg::ticks_t dmi_read_latency = 0, dmi_write_latency = 0;

 pv::bus_range_t effective_range = pv::range_begin_end_incl(dmi_data.get_start_address(), dmi_data.get_end_address());
 if (force_dmi_size)
 {
 pv::bus_range_t inner_range = effective_range;
 
 
 
 
 
 inner_range.reduce_to_contained_power_of_two_granule(GRANULARITY);
 if (inner_range.contains(tx->getAddress()))
 {
 
 
 effective_range = inner_range;
 }
 else
 {
 
 
 dmi_ok = false;
 effective_range = pv::range_begin_end_incl(tx->getAddress(), tx->getAddress());
 effective_range.expand_to_cover_power_of_two_granule(GRANULARITY);
 dmi_data.allow_read_write();
 }
 }

 unsigned char *dmi_ptr = dmi_ok ? dmi_data.get_dmi_ptr() : 0;

 
 if (effective_range.full() || ((max_size > 0) && (effective_range.size() > max_size)))
 effective_range = pv::range_begin_end(effective_range.begin, max_size - 1);

 
 if ((effective_range.begin > dmi_data.get_start_address()) && (dmi_ptr != 0))
 dmi_ptr += (effective_range.begin - dmi_data.get_start_address());
 
 
 if (dmi_data.is_read_allowed())
 {
 pv::PrefetchRange<pv::AccessRead> range (dmi_ptr, effective_range);

 tx->getPayload()->setPrefetchRange(range);
 if (dmi_ok)
 {
 dmi_read_latency = dmi_data.get_read_latency().value();
 tx->getPayload()->setReadPrefetchLatency(dmi_read_latency);
 }
 }
 if (dmi_data.is_write_allowed())
 {
 pv::PrefetchRange<pv::AccessWrite> range(dmi_ptr, effective_range);

 tx->getPayload()->setPrefetchRange(range);
 if (dmi_ok)
 {
 dmi_write_latency = dmi_data.get_write_latency().value();
 tx->getPayload()->setWritePrefetchLatency(dmi_write_latency);
 }
 }
 if (!dmi_ok)
 {
 
 
 if ((trans.is_read() && dmi_data.is_write_allowed()) ||
 (trans.is_write() && dmi_data.is_read_allowed()))
 tx->getPayload()->setPrefetchIsDeniedForOtherAccessHint();
 }
 return dmi_ok;
 
}
}

#line 490 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::init()
{
 {if(!controlPort_bus_bridge__.init.empty()) controlPort_bus_bridge__.init();};

 trans_pool.reserve(4);

 transCacheRead.reset(trans_pool.allocate(1, NULL));
 transCacheRead->set_command(tlm::TLM_READ_COMMAND);

 transCacheWrite.reset(trans_pool.allocate(1, NULL));
 transCacheWrite->set_command(tlm::TLM_WRITE_COMMAND);
 
}
}

#line 504 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::terminate()
{
 {if(!controlPort_bus_bridge__.terminate.empty()) controlPort_bus_bridge__.terminate();};
 
}
}

#line 509 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::reset(int level_)
{
 {if(!controlPort_bus_bridge__.reset.empty()) controlPort_bus_bridge__.reset(level_);};

 busDiscovery();
 
}
}

#line 517 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::busDiscovery()
{
 if (bus_node.startDiscovery(true, false))
 {
 amba_pv::amba_pv_trans_ptr trans(trans_pool.allocate(0, NULL));

 trans->set_command(tlm::TLM_IGNORE_COMMAND);
 trans->set_address(0);
 trans->set_data_ptr(NULL);
 trans->set_data_length(0);
 trans->set_streaming_width(0);

 amba_pv_m.transport_dbg(0, *trans);
 }
 bus_node.endDiscovery();
 bus_node.declareBridge(getHierarchicalName().c_str(), "PVBus", "AMBAPV");
 
}
}

#line 17 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::interconnect()
{{if(!controlPort_bus_bridge__.interconnect.empty()) controlPort_bus_bridge__.interconnect();};
}
}

#line 17 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::disconnect()
{{if(!controlPort_bus_bridge__.disconnect.empty()) controlPort_bus_bridge__.disconnect();};
}
}

#line 17 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::loadApplicationFile(const std::string& filename)
{{if(!controlPort_bus_bridge__.loadApplicationFile.empty()) controlPort_bus_bridge__.loadApplicationFile(filename);};
}
}

#line 17 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::step()
{{if(!controlPort_bus_bridge__.step.empty()) controlPort_bus_bridge__.step();};
}
}

#line 110 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { void 
Component__PVBus2AMBAPV::abstract_port__amba_pv_m__invalidate_direct_mem_ptr(int socket_id, sc_dt::uint64 start_range, sc_dt::uint64 end_range)
{
 pv::bus_addr_t base = getBaseAddress(pv::bus_addr_t(start_range));
 pv::bus_addr_t limit = getLimitAddress(pv::bus_addr_t(end_range));

 assert(limit >= base);

 control_bridge.revokePrefetch(base, limit);
 
}
}

#line 126 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { pv::Tx_Result 
Component__PVBus2AMBAPV::abstract_port__device__read(pv::ReadTransaction tx)
{
 
 if (tx.getPayload() && tx.getPayload()->isPrefetchOnly())
 return send_tlm_dmi_request(&tx, tlm::TLM_READ_COMMAND) ? tx.readComplete() : tx.wontPrefetch();
 
 pv::Tx_Result result = send_tlm_transaction(&tx, tlm::TLM_READ_COMMAND, transCacheRead.get());

 
 if (result.isUndefined())
 {
 result = tx.readComplete();

 if (tx.getBurstLength()>1)
 tx.allBeatsCompletedInOneOperation(result);
 }

 return result;
 
}
}

#line 147 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { pv::Tx_Result 
Component__PVBus2AMBAPV::abstract_port__device__write(pv::WriteTransaction tx)
{
 
 if (tx.getPayload() && tx.getPayload()->isPrefetchOnly())
 return send_tlm_dmi_request(&tx, tlm::TLM_WRITE_COMMAND) ? tx.writeComplete() : tx.wontPrefetch();
 
 pv::Tx_Result result = send_tlm_transaction(&tx, tlm::TLM_WRITE_COMMAND, transCacheWrite.get());

 
 if (result.isUndefined())
 {
 result = tx.writeComplete();

 if (tx.getBurstLength()>1)
 tx.allBeatsCompletedInOneOperation(result);
 }

 return result;
 
}
}

#line 168 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { pv::Tx_Result 
Component__PVBus2AMBAPV::abstract_port__device__debugRead(pv::ReadTransaction tx)
{
 pv::Tx_Result result = send_tlm_transaction(&tx, tlm::TLM_READ_COMMAND, true);

 
 if (result.isUndefined())
 {
 result = tx.readComplete();

 if (tx.getBurstLength()>1)
 tx.allBeatsCompletedInOneOperation(result);
 }

 return result;
 
}
}

#line 185 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPV.lisa"
namespace Cortex_NMS { pv::Tx_Result 
Component__PVBus2AMBAPV::abstract_port__device__debugWrite(pv::WriteTransaction tx)
{
 pv::Tx_Result result = send_tlm_transaction(&tx, tlm::TLM_WRITE_COMMAND, true);

 
 if (result.isUndefined())
 {
 result = tx.writeComplete();

 if (tx.getBurstLength()>1)
 tx.allBeatsCompletedInOneOperation(result);
 }

 return result;
 
}
}

#line 546 "./Linux64-Release-GCC-4.9/gen/Comp_NonDSO_2.cpp"

// ------------------------------------------------------------------------------
// implementation of class Component__PVBus2AMBAPV
// ------------------------------------------------------------------------------

namespace Cortex_NMS {

Component__PVBus2AMBAPV::Component__PVBus2AMBAPV(const char * instName, sg::SimulationContext* simulationContext, const sg::Params & params):
    SystemGenComponent(instName, simulationContext, params)

	,max_size(GetParameterValue(params, "size", INT64_C(0x1000000000000), INT64_C(0x8000000000000000), INT64_C(0x7fffffffffffffff)))
	,force_dmi_size(!!GetParameterValue(params, "force-dmi-size", INT64_C(0x1), INT64_C(0x8000000000000000), INT64_C(0x7fffffffffffffff)))
	,dmi_container_type(GetParameterValue(params, "dmi-container-type", "TZAttr"))
	,counters_file_name(GetParameterValue(params, "counters-file-name", ""))
	,min_size_to_cache(GetParameterValue(params, "min-range-to-cache", INT64_C(0x10000), INT64_C(0x1000), INT64_C(0x7fffffffffffffff)))


	,cadiParameterProxy_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV__(0)

{
    // initialize properties__
	properties__["component_name"] = "";
	properties__["component_type"] = "Bridge";
	properties__["debugger_name"] = "";
	properties__["debugger_start_command"] = "";
	properties__["default_view"] = "auto";
	properties__["description"] = "PVBus to AMBA-PV protocol converter";
	properties__["documentation_file"] = "../Docs/DUI0834H_fast_models_rm.pdf";
	properties__["dso_safe"] = "0";
	properties__["executes_software"] = "0";
	properties__["expose_extern_sub_component_cadi"] = "1";
	properties__["factory_namespace"] = "";
	properties__["has_cadi"] = "1";
	properties__["has_implicit_clk_in"] = "1";
	properties__["hidden"] = "0";
	properties__["hwversion"] = "";
	properties__["icon_file"] = "";
	properties__["ip_provider"] = "";
	properties__["is_single_stepped"] = "0";
	properties__["license_feature"] = "";
	properties__["loadfile_extension"] = "";
	properties__["small_icon_file"] = "";
	properties__["variant"] = "";
	properties__["version"] = "10.0.37";

    // initialize parameter info
    {
        sg::ComponentFactory *factory = PVBus2AMBAPV_GetFactory();

        sg::TargetInfo *targetInfo = factory->getTargetInfo(""); // empty string means 'this' component

        if(targetInfo) // if we have no target info we also have no parameters towards CADI interfaces
        {
            // get parameter infos
            for(unsigned int i = 0; i < targetInfo->parameter_count; i++)
            {
                parameterId2parameterName__[targetInfo->parameter_info[i].id] = targetInfo->parameter_info[i].name;
                parameterInfos__.push_back((targetInfo->parameter_info)[i]);
            }
        }

        factory->dereference();
    }

    // create subcomponents
	{
		sg::ComponentFactory *PVBusBridge_factory = PVBusBridge_GetFactory();
		{
			sg::Params params_bus_bridge__ = params.getParamsFor("bus_bridge");
			params_bus_bridge__["min-range-to-cache"] = min_size_to_cache;
			params_bus_bridge__["dmi-container-type"] = dmi_container_type;
			params_bus_bridge__["counters-file-name"] = counters_file_name;
			bus_bridge = PVBusBridge_factory->instantiate(subcompHierName("bus_bridge"), simulationContext, params_bus_bridge__);
			bus_bridge->setParent(this);
			add(bus_bridge);
		}
		PVBusBridge_factory->dereference();
	}


    // bind local behaviors to this->control_port
    bind_method(control_port, configure, &Component__PVBus2AMBAPV::control_port__configure, this);
    bind_method(control_port, init, &Component__PVBus2AMBAPV::init, this);
    bind_method(control_port, interconnect, &Component__PVBus2AMBAPV::interconnect, this);
    bind_method(control_port, reset, &Component__PVBus2AMBAPV::control_port__reset, this);
    bind_method(control_port, loadApplicationFile, &Component__PVBus2AMBAPV::loadApplicationFile, this);
    bind_method(control_port, serializeState, &Component__PVBus2AMBAPV::control_port__serializeState, this);
    bind_method(control_port, disconnect, &Component__PVBus2AMBAPV::disconnect, this);
    bind_method(control_port, terminate, &Component__PVBus2AMBAPV::control_port__terminate, this);
    bind_method(control_port, populateCADIMap, &Component__PVBus2AMBAPV::control_port__populateCADIMap, this);
    bind_method(control_port, step, &Component__PVBus2AMBAPV::step, this);
    bind_method(control_port, getProperty, &Component__PVBus2AMBAPV::control_port__getProperty, this);
    bind_method(control_port, bypass, &Component__PVBus2AMBAPV::control_port__bypass, this);
    bind_method(control_port, run, &Component__PVBus2AMBAPV::control_port__run, this);
    bind_method(control_port, stop, &Component__PVBus2AMBAPV::control_port__stop, this);
    bind_method(control_port, idle, &Component__PVBus2AMBAPV::control_port__idle, this);
    bind_method(control_port, quit, &Component__PVBus2AMBAPV::control_port__quit, this);
    bind_method(control_port, setSimulationEngine, &Component__PVBus2AMBAPV::control_port__setSimulationEngine, this);
    bind_method(control_port, message, &Component__PVBus2AMBAPV::control_port__message, this);
    bind_method(control_port, callSimEngine, &Component__PVBus2AMBAPV::control_port__callSimEngine, this);

    // Avoid the propagation of calls to subcomponents through the framework:
    // if setLocalOnly(true) is not called, any call to an element (connector)
    // of the control port, causes the corresponding behaviours of all
    // subcomponents to be automatically called, too. Whenever we want the
    // LISA programmer to control the propagation of special-purpose behaviours,
    // we need to prevent this to happen.
    control_port.configure.setLocalOnly(true);
    control_port.init.setLocalOnly(true);
    control_port.interconnect.setLocalOnly(true);
    control_port.reset.setLocalOnly(true);
    control_port.loadApplicationFile.setLocalOnly(true);
    control_port.serializeState.setLocalOnly(true);
    control_port.disconnect.setLocalOnly(true);
    control_port.terminate.setLocalOnly(true);
    control_port.populateCADIMap.setLocalOnly(true);
    control_port.step.setLocalOnly(true);
    control_port.getProperty.setLocalOnly(true);
//  control_port.bypass.setLocalOnly(true);
//  control_port.run.setLocalOnly(true);
//  control_port.stop.setLocalOnly(true);
//  control_port.idle.setLocalOnly(true); // broadcast ports don't have setLocalOnly
//  control_port.quit.setLocalOnly(true);
//  control_port.setSimulationEngine.setLocalOnly(true);

    // bind cadiPort behaviors
    bind_method(cadiPort__, GetParameters, &Component__PVBus2AMBAPV::cadiPort__GetParameters, this);
    bind_method(cadiPort__, GetParameterInfo, &Component__PVBus2AMBAPV::cadiPort__GetParameterInfo, this);
    bind_method(cadiPort__, GetProperty, &Component__PVBus2AMBAPV::cadiPort__GetProperty, this);
    bind_method(cadiPort__, LoadApplicationFile, &Component__PVBus2AMBAPV::cadiPort__LoadApplicationFile, this);
    bind_method(cadiPort__, GetApplicationsAndCommandLineParams, &Component__PVBus2AMBAPV::cadiPort__GetApplicationsAndCommandLineParams, this);

    // connect control ports for subcomponents to subcomponents
    connect_controlports__();


    // resource initialization code
    reset_resources__();

    // bind behaviors to abstract ports
	bind_method(amba_pv_m, invalidate_direct_mem_ptr, &Component__PVBus2AMBAPV::abstract_port__amba_pv_m__invalidate_direct_mem_ptr, this);
	bind_method(device, read, &Component__PVBus2AMBAPV::abstract_port__device__read, this);
	bind_method(device, write, &Component__PVBus2AMBAPV::abstract_port__device__write, this);
	bind_method(device, debugRead, &Component__PVBus2AMBAPV::abstract_port__device__debugRead, this);
	bind_method(device, debugWrite, &Component__PVBus2AMBAPV::abstract_port__device__debugWrite, this);


    // add abstract ports
    add_abstractports__();

    // wire up static connection map
    wire_connectionmap__();

    // init profiling

    // init resources


    // run the parameter write access functions for all of the component's parameters
    for (size_t i = 0; i < parameterInfos__.size(); ++i)
    {
        std::string paramName = parameterInfos__[i].name;

        switch (parameterInfos__[i].dataType)
        {
        case eslapi::CADI_PARAM_STRING:
            {
                std::string data = GetParameterValue(params, paramName, parameterInfos__[i].defaultString);
                parameter_write_string_func(paramNameToParamAccessFuncID(paramName), data);
            }
            break;
        case eslapi::CADI_PARAM_BOOL:
        case eslapi::CADI_PARAM_INT:
            {
                int64_t data = GetParameterValue(params, paramName, parameterInfos__[i].defaultValue, parameterInfos__[i].minValue, parameterInfos__[i].maxValue);
                parameter_write_func(paramNameToParamAccessFuncID(paramName), &data);
            }
            break;
        default:
            break;
        }
    }
}


Component__PVBus2AMBAPV::~Component__PVBus2AMBAPV()
{
}

void Component__PVBus2AMBAPV::control_port__serializeState(const char *name, cp::SerializationInterface* stream)
{
    serializeState(name, stream);
}

void Component__PVBus2AMBAPV::control_port__configure(const sg::Params& params)
{

	if(controlPort_bus_bridge__.configure.implemented()) controlPort_bus_bridge__.configure(params.getParamsFor("bus_bridge"));


    assert(simulationContext__->getSimulationEngine());
    cadi__ = new Component__PVBus2AMBAPV_CADI(this, simulationContext__->getSimulationEngine());
    buildDebugInfoWithMetaData__();

    // forward certain calls from CADI interface to this component
    cadi__->GetCADIPort().connectTo(cadiPort__);

    

    std::map< std::string, eslapi::CAInterface* > tempMap;
    control_port__populateCADIMap(tempMap, ""); // precompute mxdi map

	cadi__->EnableSubComponentCADIImport();


}

void Component__PVBus2AMBAPV::control_port__populateCADIMap(std::map< std::string, eslapi::CAInterface* >&output_map, std::string const & base_prefix)
{
    if (componentName2CADI__.empty())
    {
        componentName2CADI__[getName()] = static_cast<eslapi::CADI*>(cadi__);
        std::string prefix = getName() + ".";

		{
			std::map< std::string, eslapi::CAInterface* > compMap;
			if (controlPort_bus_bridge__.populateCADIMap.implemented())
			{
				controlPort_bus_bridge__.populateCADIMap(compMap, "");
			}
			insertCADIMap__(prefix, compMap);
			eslapi::CADI *cadi = obtainCADI__("bus_bridge", compMap);
			if (cadi != NULL)
			{
				cadiParameterProxy_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV__ = new CADIParameterProxy(cadi, &parameterFilter_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV__);
			}
		}

    }
    // Copy the local map into the given map with the requested prefix.
    for (std::map<std::string,eslapi::CAInterface*>::iterator it = componentName2CADI__.begin(); it != componentName2CADI__.end(); ++it)
    {
        output_map.insert(std::make_pair(base_prefix + it->first, it->second));
    }
}

void Component__PVBus2AMBAPV::buildDebugInfoWithMetaData__()
{
    sg::CADIBase::RegInfo regData[] =
    {

        {"ETFR", "ExtendedTargetFeatureRegisterGroup", 0, 0, eslapi::CADI_REGTYPE_STRING, "Extended Target Features", eslapi::CADI_REG_READ_ONLY, 0, 0, 0, true, 0, false, 0, 0, 0, true/*pseudo*/, true, 0xFFFFFFFF, 0, 0, 0, 0, 0xffffffff, 0, 0, false, false, false},
        {0, "", 0, 0, eslapi::CADI_REGTYPE_HEX, 0, eslapi::CADI_REG_READ_WRITE, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    };

    // the instance specific data has to be non-static, this is currently only access_data
    // this array is compressed: only registers which have hasInstanceSpecificPointers=true in regData are present here
    sg::CADIBase::RegInfoInstanceSpecific regDataInstanceSpecific[] = {

        {0, 0, 0, 0, MakeDelegate(this, &Component__PVBus2AMBAPV::GetExtendedTargetFeatures__), 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    };

    sg::CADIBase::ParamInfo paramData[] =
    {
		{ 0x10000001, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_read_func), 0, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_write_func), 0 },
		{ 0x10000002, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_read_func), 0, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_write_func), 0 },
		{ 0x10000003, 0, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_read_string_func), 0, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_write_string_func) },
		{ 0x10000004, 0, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_read_string_func), 0, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_write_string_func) },
		{ 0x10000005, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_read_func), 0, MakeDelegate(this, &Component__PVBus2AMBAPV::parameter_write_func), 0 },

        { 0, 0, 0, 0, 0 }
    };

    buildDebugInfo__(regData, (sizeof(regData) / sizeof( regData[0])) - 1,
                     regDataInstanceSpecific, sizeof(regDataInstanceSpecific) / sizeof( regDataInstanceSpecific[0]),
                     paramData, sizeof(paramData) / sizeof(paramData[0]));
}

sg::accessfunc::AccessFuncResult
Component__PVBus2AMBAPV::GetExtendedTargetFeatures__(uint32_t /*id*/, std::string &data, bool /*se*/)
{
    data = getExtendedTargetFeatures();
    return sg::accessfunc::ACCESS_FUNC_OK;
}

eslapi::CADI* Component__PVBus2AMBAPV::obtainCADI__(const std::string &subcomp, const std::map< std::string, eslapi::CAInterface* > &componentName2CADI) const
{
    std::map< std::string, eslapi::CAInterface* >::const_iterator it = componentName2CADI.find(subcomp);
    if (it != componentName2CADI.end())
    {
        eslapi::CAInterface *cai = it->second;
        if (cai != NULL)
        {
            cai = cai->ObtainInterface(eslapi::CADI::IFNAME(), 0, 0);
            if (cai != NULL)
            {
                return static_cast<eslapi::CADI*>(cai);
            }
        }
    }
    return NULL;
}

void Component__PVBus2AMBAPV::insertCADIMap__(std::string prefix, std::map< std::string, eslapi::CAInterface* > &componentName2CADI)
{
    for (std::map<std::string, eslapi::CAInterface*>::iterator it = componentName2CADI.begin(); it != componentName2CADI.end(); it++)
    {
        // put prefix in front of all entries
        componentName2CADI__[prefix + it->first] = it->second;
    }
}


std::string Component__PVBus2AMBAPV::control_port__getProperty(const std::string& propname)
{
    if(properties__.find(propname) != properties__.end())
    {
        return properties__[propname];
    }
    else
        return ""; // unknown property
}

std::string Component__PVBus2AMBAPV::control_port__bypass(const std::string&)
{
    return "";
}

void Component__PVBus2AMBAPV::control_port__run()
{
}


void Component__PVBus2AMBAPV::control_port__stop()
{
}


void Component__PVBus2AMBAPV::control_port__idle()
{
}


void Component__PVBus2AMBAPV::control_port__quit()
{
}


void Component__PVBus2AMBAPV::control_port__setSimulationEngine(SimulationEngine*)
{
}


void Component__PVBus2AMBAPV::control_port__message(const std::string &msg, sg::message::MessageType msgType)
{
}


std::string Component__PVBus2AMBAPV::control_port__callSimEngine(const std::string &)
{
    return "";
}


void Component__PVBus2AMBAPV::control_port__reset(int level)
{
    // restore the resources' reset values before executing 'reset'
    reset_resources__();
    reset(level);
}


void Component__PVBus2AMBAPV::control_port__terminate()
{
    // the CADI was created before 'init', therefore we free it after 'terminate'
    terminate();
    freeCADIResources__();
}


void Component__PVBus2AMBAPV::freeCADIResources__()
{
    // free CADI parameter proxies
	delete cadiParameterProxy_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV__;
	cadiParameterProxy_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV__ = 0;


    // free CADI interface
    delete cadi__;
    cadi__ = 0;
}


// CADI Port implementations
eslapi::CADIReturn_t Component__PVBus2AMBAPV::cadiPort__GetParameters(uint32_t startIndex, uint32_t desiredNumOfParams, uint32_t *actualNumOfParams, eslapi::CADIParameterInfo_t *params)
{
    // check arguments
    if(actualNumOfParams == 0)
        return eslapi::CADI_STATUS_IllegalArgument;
    *actualNumOfParams = 0;
    if(params == 0)
        return eslapi::CADI_STATUS_IllegalArgument;

    // collect parameters
    uint32_t i = 0;
    for (; (i < desiredNumOfParams) && ((startIndex + i) < parameterInfos__.size()); ++i)
    {
        params[i] = parameterInfos__[startIndex + i];
    }
    *actualNumOfParams = i;

    return eslapi::CADI_STATUS_OK;
}

eslapi::CADIReturn_t Component__PVBus2AMBAPV::cadiPort__GetParameterInfo(const std::string &parameterName, eslapi::CADIParameterInfo_t* param)
{
    if(param == 0)
        return eslapi::CADI_STATUS_IllegalArgument;

    for (size_t i = 0; i < parameterInfos__.size(); ++i)
    {
        if (!strcmp(parameterInfos__[i].name, parameterName.c_str()))
        {
            *param = parameterInfos__[i];

            return eslapi::CADI_STATUS_OK;
        }
    }

    return eslapi::CADI_STATUS_GeneralError;
}


bool Component__PVBus2AMBAPV::ForwardParameterValueToSubcomponent(CADIParameterProxy *proxy, const char *param_name, int64_t intVal, const char *strVal)
{
    if (!proxy)
        return false;

    // we need the parameter's CADI id in order to create an eslapi::CADIParameterValue_t structure
    // therefore, we first retrieve its eslapi::CADIParameterInfo_t meta-data
    eslapi::CADIParameterInfo_t paramInfo;
    if (proxy->CADIGetParameterInfo(param_name, &paramInfo) != eslapi::CADI_STATUS_OK)
        return false;

    eslapi::CADIParameterValue_t paramVal(paramInfo.id, paramInfo.dataType, intVal, strVal);
    eslapi::CADIFactoryErrorMessage_t error;
    if (proxy->CADISetParameters(1, &paramVal, &error) != eslapi::CADI_STATUS_OK)
        return false;

    return true;
}


sg::accessfunc::AccessFuncResult Component__PVBus2AMBAPV::parameter_read_func(uint32_t id, int64_t *data)
{
    if (data == 0)
        return eslapi::CADI_STATUS_IllegalArgument;

    switch (id)
    {
	case PARAMETER_ID_max_size: *data = max_size; break;
	case PARAMETER_ID_force_dmi_size: *data = force_dmi_size; break;
	case PARAMETER_ID_min_size_to_cache: *data = min_size_to_cache; break;

        default:
            printf("error: Component__PVBus2AMBAPV::parameter_read_func: undefined parameter id '0x%08x'\n", id);
            return sg::accessfunc::ACCESS_FUNC_GeneralError;
    }

    return sg::accessfunc::ACCESS_FUNC_OK;
}

sg::accessfunc::AccessFuncResult Component__PVBus2AMBAPV::parameter_read_string_func(uint32_t id, std::string &data)
{
    switch (id)
    {
	case PARAMETER_ID_dmi_container_type:  data = dmi_container_type; break;
	case PARAMETER_ID_counters_file_name:  data = counters_file_name; break;

        default:
            printf("error: Component__PVBus2AMBAPV::parameter_read_string_func: undefined parameter id '0x%08x'\n", id);
            return sg::accessfunc::ACCESS_FUNC_GeneralError;
    }

    return sg::accessfunc::ACCESS_FUNC_OK;
}

sg::accessfunc::AccessFuncResult Component__PVBus2AMBAPV::parameter_write_func(uint32_t id, const int64_t *data)
{
    if (data == 0)
        return eslapi::CADI_STATUS_IllegalArgument;

    switch (id)
    {
	case PARAMETER_ID_max_size:
		{
			*(const_cast<uint64_t*>(&max_size)) = *data;
		}
		break;
	case PARAMETER_ID_force_dmi_size:
		{
			*(const_cast<bool*>(&force_dmi_size)) = !!*data;
		}
		break;
	case PARAMETER_ID_min_size_to_cache:
		{
			*(const_cast<uint32_t*>(&min_size_to_cache)) = *data;
		}
		break;

        default:
            printf("error: Component__PVBus2AMBAPV::parameter_write_func: undefined parameter id '0x%08x'\n", id);
            return sg::accessfunc::ACCESS_FUNC_GeneralError;
    }

    return sg::accessfunc::ACCESS_FUNC_OK;
}

sg::accessfunc::AccessFuncResult Component__PVBus2AMBAPV::parameter_write_string_func(uint32_t id, const std::string &data)
{
    switch (id)
    {
	case PARAMETER_ID_dmi_container_type:
		{
			*(const_cast<std::string*>(&dmi_container_type)) = data;
		}
		break;
	case PARAMETER_ID_counters_file_name:
		{
			*(const_cast<std::string*>(&counters_file_name)) = data;
		}
		break;

        default:
            printf("error: Component__PVBus2AMBAPV::parameter_write_string_func: undefined parameter id '0x%08x'\n", id);
            return sg::accessfunc::ACCESS_FUNC_GeneralError;
    }

    return sg::accessfunc::ACCESS_FUNC_OK;
}

void Component__PVBus2AMBAPV::cadiPort__LoadApplicationFile(const std::string& filename)
{
    loadApplicationFile(filename);
    applications2params[filename] = "";
}

void Component__PVBus2AMBAPV::cadiPort__GetApplicationsAndCommandLineParams(std::map<std::string, std::string>&applications2params_)
{
    applications2params_ = applications2params;
}

eslapi::CADIReturn_t Component__PVBus2AMBAPV::cadiPort__GetProperty(const std::string& propertyName, std::string &value)
{
    if(properties__.find(propertyName) != properties__.end())
    {
        value = properties__[propertyName];
        return eslapi::CADI_STATUS_OK;
    }
    else
    {
        value = "";
        return eslapi::CADI_STATUS_GeneralError;
    }
}

// functions to stop and lock the simulator
// we only expose the simHalt() function in the documentation for the moment

void Component__PVBus2AMBAPV::simHalt()
{
    cadi__->StopSimulation();
}


// start simulation from the inside
// (useful from visualisation components which can execute code while the
// simulation is stopped, like key events)
void Component__PVBus2AMBAPV::simRun()
{
    cadi__->CADIExecContinue();
}


// return true if simulation is running
// (useful from visualisation components which can execute code while the
// simulation is stopped, like key events)
bool Component__PVBus2AMBAPV::simIsRunning()
{
    uint32_t mode = eslapi::CADI_EXECMODE_Stop;
    cadi__->CADIExecGetMode(&mode);
    return mode != eslapi::CADI_EXECMODE_Stop;
}


void Component__PVBus2AMBAPV::simShutdown()
{
    cadiPort__.simShutdown();
}

void Component__PVBus2AMBAPV::simReset(uint32_t level)
{
    cadi__->CADIExecReset(level);
}

uint32_t Component__PVBus2AMBAPV::paramNameToParamAccessFuncID(const std::string &name)
{
    uint32_t id = 0;
    if (name == "") id = 0xffffffff;
    if (name == "size") id = PARAMETER_ID_max_size;
    if (name == "force-dmi-size") id = PARAMETER_ID_force_dmi_size;
    if (name == "dmi-container-type") id = PARAMETER_ID_dmi_container_type;
    if (name == "counters-file-name") id = PARAMETER_ID_counters_file_name;
    if (name == "min-range-to-cache") id = PARAMETER_ID_min_size_to_cache;

    return id;
}

void Component__PVBus2AMBAPV::reset_resources__()
{
    // resource initialization code

}

void Component__PVBus2AMBAPV::connect_controlports__()
{
    typedef struct {
        sg::Port * local_cport_name;
        sg::ComponentBase * local_instance_name;
        const char * cport_name;
    } connection_map_t;


    connection_map_t cmap[] = {
    {&controlPort_bus_bridge__,bus_bridge,"$control"},
    { 0, 0, 0 },
    };


    for(unsigned int i=0; cmap[i].local_cport_name != 0; i++) {
        connection_map_t c = cmap[i];
        c.local_cport_name->connectTo(c.local_instance_name->findPort(c.cport_name));
    }


    // #CONNECT_CONTROLPORTS_TO_SUBCOMPONENTS#
}

void Component__PVBus2AMBAPV::add_abstractports__0__()
{
	publishSlavePort("pvbus_s", pvbus_s);
	pvbus_s.SetName__("pvbus_s");
	publishSlavePort("reset_bus_interfaces", reset_bus_interfaces);
	reset_bus_interfaces.SetName__("reset_bus_interfaces");
	publishMasterPort("amba_pv_m", amba_pv_m);
	amba_pv_m.SetName__("amba_pv_m");
	control_bridge.SetName__("control_bridge");
	device.SetName__("device");
}



void Component__PVBus2AMBAPV::add_abstractports__()
{
	add_abstractports__0__();

}

void Component__PVBus2AMBAPV::wire_connectionmap__0__()
{
	pvbus_s.connectTo(bus_bridge->findPort("pvbus_s"));
	bus_bridge->findPort("device").connectTo(device);
	reset_bus_interfaces.connectTo(bus_bridge->findPort("reset"));
	control_bridge.connectTo(bus_bridge->findPort("control"));
}



void Component__PVBus2AMBAPV::wire_connectionmap__()
{
	wire_connectionmap__0__();

}


} // Cortex_NMS

#line 1235 "./Linux64-Release-GCC-4.9/gen/Comp_NonDSO_2.cpp"

// This is an anonymous namespace, it effectively declares everything inside it as 'static', e.g. only visible within the .o file it is compiled into
//     without this we get link errors when linking together LISA generated components
namespace
{

class ComponentFactoryBase :
    public sg::BasicComponentFactory
{
protected:
    void publishSubComponent(sg::ComponentFactory *factory,
                             const std::string &prefix,
                             bool publish_all,
                             const ParameterFilter &param_filter);
};

void
ComponentFactoryBase::publishSubComponent(sg::ComponentFactory *factory,
                                          const std::string &prefix,
                                          bool publish_all,
                                          const ParameterFilter &param_filter)
{
    using namespace sg;

    if (param_filter.isEmpty())
    {
        BasicComponentFactory::publishComponent(factory, prefix, publish_all);
    }
    else
    {
        for (unsigned int t = 0; t < factory->getTargetCount(); ++t)
        {
            TargetInfo *info = factory->getTargetInfo(t);

            std::vector<eslapi::CADIParameterInfo_t> my_param_infos;

            param_filter.filter(info->parameter_info, info->parameter_count, info->instance_path, my_param_infos);

            TargetInfo *my_target_info = new TargetInfo;

                        eslapi::CADITargetInfo_t *my_cadi_target_info = new eslapi::CADITargetInfo_t;
                        *my_cadi_target_info = *(info->cadi_target_info); // copy CADI target info
            my_cadi_target_info->numberOfParameters = (uint32_t)my_param_infos.size();
            my_target_info->cadi_target_info = my_cadi_target_info;

            my_target_info->parameter_count = (unsigned)my_param_infos.size();

            // only copy parameters, if there are ones
                        if (my_target_info->parameter_count)
                        {
                                my_target_info->parameter_info = new eslapi::CADIParameterInfo_t[my_target_info->parameter_count];
                                memcpy(const_cast<eslapi::CADIParameterInfo_t *>(my_target_info->parameter_info),
                                           &my_param_infos.front(),
                                           sizeof(eslapi::CADIParameterInfo_t) * my_target_info->parameter_count);
                        }

            my_target_info->instance_path = info->instance_path;

            // Skip any targets that have an instance_path of "".
            if (my_target_info->instance_path.length() > 0)
            {
                // Add the prefix at the start of the instance path.
                std::string new_path = prefix + "." + my_target_info->instance_path;
                publishTarget(*my_target_info, new_path);
            }
            else if (publish_all)
            {
                std::string new_path = prefix;
                publishTarget(*my_target_info, new_path);
            }
            delete my_target_info;
        }
    }
}

}

using namespace Cortex_NMS;

// component factory implementation
// ------------------------------------------------------------------------------
// component factory of class PVBus2AMBAPV
// ------------------------------------------------------------------------------
//


namespace
{

// component factory class
// (this concrete class is never exposed to the outside world)
class PVBus2AMBAPV_ComponentFactoryClass: public ComponentFactoryBase
{
    bool componentsPublished;
    void lazyPublish(void)
    {
        static eslapi::CADITargetInfo_t info
        (
            0, /* uint32_t id; (overridden in CADIFactory) */                                                              // used for identification
            "PVBus2AMBAPV", /* char  targetName[CADI_NAME_SIZE];     */      // name of the target, i.e. the "type", not the instance name
            "", /* char instanceName[CADI_NAME_SIZE]; (overridden in CADIFactory) */    // name of the CADI target instance
            "10.0.37", /* char        version[CADI_DESCRIPTION]; */           // version string
            "PVBus to AMBA-PV protocol converter", /* char    description[CADI_DESCRIPTION]; */       // target description
            "Bridge", /* char componentType[CADI_NAME_SIZE]; */       // classification of the target into a user-defined group
            0, /* uint32_t numberOfParameters; (overridden below) */                               // number of parameters supported
            0, /* bool        executesSoftware; */                            // false = does not execute programs, true = executes software
            false, /* uint32_t     isHardwareModel; */                             // 0 = is software model, 1 = is hardware model
            "", /* char systemName[CADI_NAME_SIZE];  (overridden in CADIFactory) */             // name of the system the target belongs to.
            // Is empty for single-core standalone models.
            0, /* uint32_t systemID; (overridden in CADIFactory) */                                                // system id
            "" /* char  systemDescription[CADI_DESCRIPTION]; (overridden in CADIFactory) */ // description of the system
        );

        static eslapi::CADIParameterInfo_t parameters[] =
        {
        eslapi::CADIParameterInfo_t(0x10000001, "size",eslapi::CADI_PARAM_INT, "Maximum size of memory region",0,INT64_C(0x8000000000000000),INT64_C(0x7fffffffffffffff),INT64_C(0x1000000000000), "0x1000000000000" ),
        eslapi::CADIParameterInfo_t(0x10000002, "force-dmi-size",eslapi::CADI_PARAM_BOOL, "Force DMI start and end address to be 4kB-aligned",0,INT64_C(0x8000000000000000),INT64_C(0x7fffffffffffffff),INT64_C(0x1), "true" ),
        eslapi::CADIParameterInfo_t(0x10000003, "dmi-container-type",eslapi::CADI_PARAM_STRING, "Type of the DMI cache. Allowed values: TZAttr and FullAttr",0,INT64_C(0x8000000000000000),INT64_C(0x7fffffffffffffff),INT64_C(0x0), "TZAttr" ),
        eslapi::CADIParameterInfo_t(0x10000004, "counters-file-name",eslapi::CADI_PARAM_STRING, "Prefix of the file name to store counters at the end of simulation",0,INT64_C(0x8000000000000000),INT64_C(0x7fffffffffffffff),INT64_C(0x0), "" ),
        eslapi::CADIParameterInfo_t(0x10000005, "min-range-to-cache",eslapi::CADI_PARAM_INT, "Min DMI range size to cache in the bridge",0,INT64_C(0x1000),INT64_C(0x7fffffffffffffff),INT64_C(0x10000), "0x10000" ),

            eslapi::CADIParameterInfo_t( 0, "", eslapi::CADI_PARAM_BOOL, "", 1, INT64_C(0), INT64_C(-1), 0, "0" )
        };
        info.numberOfParameters = (sizeof(parameters) / sizeof(parameters[0])) - 1;

        // build TargetInfo
        sg::TargetInfo targetInfo;
        targetInfo.cadi_target_info = &info;
        targetInfo.parameter_count = targetInfo.cadi_target_info->numberOfParameters;
        targetInfo.parameter_info = parameters;

        // publish this component's TargetInfo
        publishTarget(targetInfo, "");

        // publish subcomponent TargetInfos
        {
            sg::ComponentFactory *componentFactory = PVBusBridge_GetFactory();
            ComponentFactoryBase::publishSubComponent(componentFactory, "bus_bridge", true, ParameterFilter_bus_bridge_of_PVBusBridge_to_PVBus2AMBAPV());
            componentFactory->dereference();
        }

        componentsPublished = true;
    }
    ~PVBus2AMBAPV_ComponentFactoryClass()
    {
    }

public:
    PVBus2AMBAPV_ComponentFactoryClass() {
        componentsPublished = false;
    }

    virtual void dereference() { delete this; }

    virtual sg::ComponentBase *instantiate(std::string const & instance_name,
                                                sg::SimulationContext *simulationContext,
                                                sg::Params const & params)
    {
        return new Cortex_NMS::Component__PVBus2AMBAPV(instance_name.c_str(), simulationContext, params);
    }

    virtual unsigned int getTargetCount()
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::getTargetCount();
    }

    virtual sg::TargetInfo * getTargetInfo(unsigned int index)
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::getTargetInfo(index);
    }

    virtual sg::TargetInfo * getTargetInfo(std::string const & instance_path)
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::getTargetInfo(instance_path);
    }

    virtual void publishSubComponent(sg::ComponentFactory *factory, const std::string &prefix,
                          bool publish_all, const ParameterFilter &param_filter)
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::publishSubComponent(factory, prefix, publish_all, param_filter);
    }

    virtual void publishComponent(sg::ComponentFactory *factory, const std::string &prefix,
                          bool publish_all)
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::publishComponent(factory, prefix, publish_all);
    }

};

}

namespace Cortex_NMS {

// factory function
// (this is the function which is exposed to the outside world)
sg::ComponentFactory *PVBus2AMBAPV_GetFactory()
{
        return new PVBus2AMBAPV_ComponentFactoryClass();
}

} // Cortex_NMS

