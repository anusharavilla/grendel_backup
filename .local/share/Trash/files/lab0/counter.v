/*module************************************
*
* NAME: down counter
*
* DESCRIPTION:
*  downcounter with zero flag and synchronous clear
*
* NOTES:
*
* REVISION HISTORY
*    Date     Programmer    Description
*    7/10/97  P. Franzon    ece520-specific version
*
*M*/

/*======Declarations===============================*/

module counter (clock, in, latch, dec,  zero, divide_by_two);


/*-----------Inputs--------------------------------*/

input       clock;  /* clock */
input [7:0] in;  /* input initial count */
input       latch;  /* `latch input' */
input       dec;   /* decrement */
input       divide_by_two;

/*-----------Outputs--------------------------------*/

output      zero;  /* zero flag */

/*----------------Nets and Registers----------------*/
/*---(See input and output for unexplained variables)---*/

reg [7:0] value;       /* current count value */
wire      zero;

// Count Flip-flops with input multiplexor
always@(posedge clock)
  begin  // begin-end not actually need here as there is only one statement
    if (latch) value <= in;
    else if (dec && !zero) value <= value - 1'b1;
    else if (!dec && !zero && divide_by_two) value<= value>>1;
      
  end

// combinational logic for zero flag
assign zero = ~|value;

endmodule /* counter */
