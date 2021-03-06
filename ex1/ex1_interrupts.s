
CMU_HFPERCLKEN0_GPIO = 13 //   b i t   r e p r e s e n t i n g   GPIO

 // gdb layout regs - si
        .syntax unified

	      .include "efm32gg.s"

	/////////////////////////////////////////////////////////////////////////////
	//
  // Exception vector table
  // This table contains addresses for all exception handlers
	//
	/////////////////////////////////////////////////////////////////////////////

        .section .vectors

	      .long   stack_top               /* Top of Stack                 */
	      .long   _reset                  /* Reset Handler                */
	      .long   dummy_handler           /* NMI Handler                  */
	      .long   dummy_handler           /* Hard Fault Handler           */
	      .long   dummy_handler           /* MPU Fault Handler            */
	      .long   dummy_handler           /* Bus Fault Handler            */
	      .long   dummy_handler           /* Usage Fault Handler          */
	      .long   dummy_handler           /* Reserved                     */
	      .long   dummy_handler           /* Reserved                     */
	      .long   dummy_handler           /* Reserved                     */
	      .long   dummy_handler           /* Reserved                     */
	      .long   dummy_handler           /* SVCall Handler               */
	      .long   dummy_handler           /* Debug Monitor Handler        */
	      .long   dummy_handler           /* Reserved                     */
	      .long   dummy_handler           /* PendSV Handler               */
	      .long   dummy_handler           /* SysTick Handler              */

	      /* External Interrupts */
	      .long   dummy_handler
	      .long   gpio_handler            /* GPIO even handler */
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   gpio_handler            /* GPIO odd handler */
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler
	      .long   dummy_handler

	      .section .text

	/////////////////////////////////////////////////////////////////////////////
	//
	// Reset handler
    // The CPU will start executing here after a reset
	//
	/////////////////////////////////////////////////////////////////////////////

	      .globl  _reset
	      .type   _reset, %function
        .thumb_func
_reset:
		  //Enable clk
	      ldr r1, cmu_base_addr //load CMU base adress
	      ldr r2, [r1, #CMU_HFPERCLKEN0] //load current value HPFERCLK ENABLE
	      //set bit gpio clk
	      mov r3, #1
	      lsl r3, r3, #CMU_HFPERCLKEN0_GPIO
	      orr r2, r2, r3
	      //store new value
	      str r2,[r1, #CMU_HFPERCLKEN0]

	      //set high drive strength
	      ldr r1, gpio_pa_base_addr
	      mov r2, #0x2
	      str r2, [r1, #GPIO_CTRL]

	      //set pins to output
	      mov r2, #0x55555555
	      str r2, [r1, #GPIO_MODEH]

	      //buttons setup in input
	      ldr r2, gpio_pc_base_addr
	      mov r3, 0x33333333
	      str r3, [r2, #GPIO_MODEL]
	      mov r3, 0xff
	      str r3, [r2, #GPIO_DOUT]

	   loop:

	      ldr r3, [r2, #GPIO_DIN]
	      lsl r3, r3, #8
	      str r3, [r1, #GPIO_DOUT]
	      b loop



cmu_base_addr:
			.long CMU_BASE

gpio_pa_base_addr:
			.long GPIO_PA_BASE

gpio_pc_base_addr:
			.long GPIO_PC_BASE
	/////////////////////////////////////////////////////////////////////////////
	//
  // GPIO handler
  // The CPU will jump here when there is a GPIO interrupt
	//
	/////////////////////////////////////////////////////////////////////////////

        .thumb_func
gpio_handler:

	      b .  // do nothing

	/////////////////////////////////////////////////////////////////////////////

        .thumb_func
dummy_handler:
        b .  // do nothing
