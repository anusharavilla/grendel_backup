/*****************************************************************************

  The following code is derived, directly or indirectly, from the SystemC
  source code Copyright (c) 1996-2008 by all Contributors.
  All Rights reserved.

  The contents of this file are subject to the restrictions and limitations
  set forth in the SystemC Open Source License Version 3.0 (the "License");
  You may not use this file except in compliance with such restrictions and
  limitations. You may obtain instructions on how to receive a copy of the
  License at http://www.systemc.org/. Software distributed by Contributors
  under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
  ANY KIND, either express or implied. See the License for the specific
  language governing rights and limitations under the License.

 *****************************************************************************/

#ifndef __SIMPLEBUSLT_H__
#define __SIMPLEBUSLT_H__

//#include <systemc>
#include "tlm.h"

#include "tlm_utils/simple_target_socket.h"
#include "tlm_utils/simple_initiator_socket.h"

template <int NR_OF_INITIATORS, int NR_OF_TARGETS>
class SimpleBusLT : public sc_core::sc_module
{
public:
  typedef tlm::tlm_generic_payload                 transaction_type;
  typedef tlm::tlm_phase                           phase_type;
  typedef tlm::tlm_sync_enum                       sync_enum_type;
  typedef tlm_utils::simple_target_socket_tagged<SimpleBusLT, 64, tlm::tlm_base_protocol_types>    target_socket_type;
  typedef tlm_utils::simple_initiator_socket_tagged<SimpleBusLT, 64, tlm::tlm_base_protocol_types> initiator_socket_type;

public:
  target_socket_type target_socket[NR_OF_INITIATORS];
  initiator_socket_type initiator_socket[NR_OF_TARGETS];
 long long int src_address,dest_address,dma_length;

public:
  SC_HAS_PROCESS(SimpleBusLT);
  SimpleBusLT(sc_core::sc_module_name name) :
    sc_core::sc_module(name)
  {
    for (unsigned int i = 0; i < NR_OF_INITIATORS; ++i) {
      target_socket[i].register_b_transport(this, &SimpleBusLT::initiatorBTransport, i);
      target_socket[i].register_transport_dbg(this, &SimpleBusLT::transportDebug, i);
      target_socket[i].register_get_direct_mem_ptr(this, &SimpleBusLT::getDMIPointer, i);
    }
    for (unsigned int i = 0; i < NR_OF_TARGETS; ++i) {
      initiator_socket[i].register_invalidate_direct_mem_ptr(this, &SimpleBusLT::invalidateDMIPointers, i);
    }
  }

  //
  // Dummy decoder:
  // - address[31-28]: portId
  // - address[27-0]: masked address
  //

  unsigned int getPortId(const sc_dt::uint64& address)
  {
    return (unsigned int)address >> 28;
  }

  sc_dt::uint64 getAddressOffset(unsigned int portId)
  {
    return portId << 28;
  }

  sc_dt::uint64 getAddressMask(unsigned int portId)
  {
    return 0xfffffff;
  }

  unsigned int decode(const sc_dt::uint64& address)
  {
    // decode address:
    // - return initiator socket id

    return getPortId(address);
  }

  //
  // interface methods
  //

  //
  // LT protocol
  // - forward each call to the target/initiator
  //
  void initiatorBTransport(int SocketId,
                           transaction_type& trans,
                           sc_core::sc_time& t)
  { 
    bool readyDMA = false;
   //unsigned char *dp;//unsigned int data;//transaction_type& payload;
    initiator_socket_type* decodeSocket;
    //unsigned int portId = decode(trans.get_address());
    //assert(portId < NR_OF_TARGETS);
    decodeSocket = &initiator_socket[0];
    //trans.set_address(trans.get_address() & getAddressMask(portId));
  
     switch(trans.get_address()) // dma send address is detected 
{
      case 0x40000010: // source
      src_address = *reinterpret_cast<unsigned int*>(trans.get_data_ptr());
      std::cout<<"\ndma source address is seen as:"<<src_address<<"\n";
      break;
      case 0x40000060: //destination 
      dest_address = *reinterpret_cast<unsigned int*>(trans.get_data_ptr());
      std::cout<<"\ndma destination address is seen as:"<<dest_address<<"\n";
      break;
      case 0x40000090: //length
      dma_length = *reinterpret_cast<unsigned int*>(trans.get_data_ptr()); //(long long int)*trans.get_data_ptr();
      std::cout<<"\ndma length  is seen as:"<<dma_length<<"\n";
      readyDMA = true;
      break;
      default:
      break;
}

   if(readyDMA)
  {

for(int i=0; i<dma_length; i++)
{
   // read from source address into gp  
   trans.set_command( tlm::TLM_READ_COMMAND );
   trans.set_address( src_address + i*4);
   trans.set_data_length( 4 );
   trans.set_streaming_width( 4 );
   trans.set_byte_enable_length( 1 );
   //dp = trans.get_data_ptr();
   //data = *reinterpret_cast<unsigned int*>(dp);
  trans.set_response_status( tlm::TLM_OK_RESPONSE );   
   (*decodeSocket)->b_transport(trans, t);
 

   // write to destination address from gp
  trans.set_command( tlm::TLM_WRITE_COMMAND );
  trans.set_address( dest_address + i*4 );
  trans.set_data_length( 4 );
  trans.set_streaming_width( 4 );
  trans.set_byte_enable_length( 1 );
  //dp = trans.get_data_ptr();
  //*reinterpret_cast<unsigned int*>(dp)=data;
  trans.set_response_status( tlm::TLM_INCOMPLETE_RESPONSE );
  
 (*decodeSocket)->b_transport(trans, t); }

   }

else 
{  trans.set_byte_enable_length( 0 );
 (*decodeSocket)->b_transport(trans, t);
 }   
  }

  unsigned int transportDebug(int SocketId,
                              transaction_type& trans)
  {
    unsigned int portId = decode(trans.get_address());
    assert(portId < NR_OF_TARGETS);
    initiator_socket_type* decodeSocket = &initiator_socket[portId];
    trans.set_address( trans.get_address() & getAddressMask(portId) );
    
    return (*decodeSocket)->transport_dbg(trans);
  }

  bool limitRange(unsigned int portId, sc_dt::uint64& low, sc_dt::uint64& high)
  {
    sc_dt::uint64 addressOffset = getAddressOffset(portId);
    sc_dt::uint64 addressMask = getAddressMask(portId);

    if (low > addressMask) {
      // Range does not overlap with addressrange for this target
      return false;
    }

    low += addressOffset;
    if (high > addressMask) {
      high = addressOffset + addressMask;

    } else {
      high += addressOffset;
    }
    return true;
  }

  bool getDMIPointer(int SocketId,
                     transaction_type& trans,
                     tlm::tlm_dmi&  dmi_data)
  {
    sc_dt::uint64 address = trans.get_address();

    unsigned int portId = decode(address);
    assert(portId < NR_OF_TARGETS);
    initiator_socket_type* decodeSocket = &initiator_socket[portId];
    sc_dt::uint64 maskedAddress = address & getAddressMask(portId);

    trans.set_address(maskedAddress);

    bool result =
      (*decodeSocket)->get_direct_mem_ptr(trans, dmi_data);
    
    if (result)
    {
      // Range must contain address
      assert(dmi_data.get_start_address() <= maskedAddress);
      assert(dmi_data.get_end_address() >= maskedAddress);
    }
    
    // Should always succeed
	sc_dt::uint64 start, end;
	start = dmi_data.get_start_address();
	end = dmi_data.get_end_address();
	
	limitRange(portId, start, end);
	
	dmi_data.set_start_address(start);
	dmi_data.set_end_address(end);

    return result;
  }

  void invalidateDMIPointers(int port_id,
                             sc_dt::uint64 start_range,
                             sc_dt::uint64 end_range)
  {
    // FIXME: probably faster to always invalidate everything?

    if (!limitRange(port_id, start_range, end_range)) {
      // Range does not fall into address range of target
      return;
    }
    
    for (unsigned int i = 0; i < NR_OF_INITIATORS; ++i) {
      (target_socket[i])->invalidate_direct_mem_ptr(start_range, end_range);
    }
  }

};

#endif
