// first_nios2_system.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module first_nios2_system (
		input  wire        clk_clk,                            //                         clk.clk
		output wire        dram_clk_clk,                       //                    dram_clk.clk
		output wire [7:0]  led_pio_external_connection_export, // led_pio_external_connection.export
		input  wire        reset_reset_n,                      //                       reset.reset_n
		output wire [11:0] sdram_wire_addr,                    //                  sdram_wire.addr
		output wire [1:0]  sdram_wire_ba,                      //                            .ba
		output wire        sdram_wire_cas_n,                   //                            .cas_n
		output wire        sdram_wire_cke,                     //                            .cke
		output wire        sdram_wire_cs_n,                    //                            .cs_n
		inout  wire [15:0] sdram_wire_dq,                      //                            .dq
		output wire [1:0]  sdram_wire_dqm,                     //                            .dqm
		output wire        sdram_wire_ras_n,                   //                            .ras_n
		output wire        sdram_wire_we_n                     //                            .we_n
	);

	wire         pll_0_outclk0_clk;                                         // pll_0:outclk_0 -> [cpu:clk, dma_0:clk, f_of_x_0:clk, irq_mapper:clk, jtag_uart:clk, led_pio:clk, mm_interconnect_0:pll_0_outclk0_clk, rst_controller:clk, sdram:clk, sys_clk_timer:clk, sysid:clock]
	wire  [31:0] cpu_data_master_readdata;                                  // mm_interconnect_0:cpu_data_master_readdata -> cpu:d_readdata
	wire         cpu_data_master_waitrequest;                               // mm_interconnect_0:cpu_data_master_waitrequest -> cpu:d_waitrequest
	wire         cpu_data_master_debugaccess;                               // cpu:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:cpu_data_master_debugaccess
	wire  [24:0] cpu_data_master_address;                                   // cpu:d_address -> mm_interconnect_0:cpu_data_master_address
	wire   [3:0] cpu_data_master_byteenable;                                // cpu:d_byteenable -> mm_interconnect_0:cpu_data_master_byteenable
	wire         cpu_data_master_read;                                      // cpu:d_read -> mm_interconnect_0:cpu_data_master_read
	wire         cpu_data_master_readdatavalid;                             // mm_interconnect_0:cpu_data_master_readdatavalid -> cpu:d_readdatavalid
	wire         cpu_data_master_write;                                     // cpu:d_write -> mm_interconnect_0:cpu_data_master_write
	wire  [31:0] cpu_data_master_writedata;                                 // cpu:d_writedata -> mm_interconnect_0:cpu_data_master_writedata
	wire  [31:0] cpu_instruction_master_readdata;                           // mm_interconnect_0:cpu_instruction_master_readdata -> cpu:i_readdata
	wire         cpu_instruction_master_waitrequest;                        // mm_interconnect_0:cpu_instruction_master_waitrequest -> cpu:i_waitrequest
	wire  [24:0] cpu_instruction_master_address;                            // cpu:i_address -> mm_interconnect_0:cpu_instruction_master_address
	wire         cpu_instruction_master_read;                               // cpu:i_read -> mm_interconnect_0:cpu_instruction_master_read
	wire         cpu_instruction_master_readdatavalid;                      // mm_interconnect_0:cpu_instruction_master_readdatavalid -> cpu:i_readdatavalid
	wire         dma_0_read_master_chipselect;                              // dma_0:read_chipselect -> mm_interconnect_0:dma_0_read_master_chipselect
	wire  [31:0] dma_0_read_master_readdata;                                // mm_interconnect_0:dma_0_read_master_readdata -> dma_0:read_readdata
	wire         dma_0_read_master_waitrequest;                             // mm_interconnect_0:dma_0_read_master_waitrequest -> dma_0:read_waitrequest
	wire  [23:0] dma_0_read_master_address;                                 // dma_0:read_address -> mm_interconnect_0:dma_0_read_master_address
	wire         dma_0_read_master_read;                                    // dma_0:read_read_n -> mm_interconnect_0:dma_0_read_master_read
	wire         dma_0_read_master_readdatavalid;                           // mm_interconnect_0:dma_0_read_master_readdatavalid -> dma_0:read_readdatavalid
	wire         dma_0_write_master_chipselect;                             // dma_0:write_chipselect -> mm_interconnect_0:dma_0_write_master_chipselect
	wire         dma_0_write_master_waitrequest;                            // mm_interconnect_0:dma_0_write_master_waitrequest -> dma_0:write_waitrequest
	wire   [4:0] dma_0_write_master_address;                                // dma_0:write_address -> mm_interconnect_0:dma_0_write_master_address
	wire   [3:0] dma_0_write_master_byteenable;                             // dma_0:write_byteenable -> mm_interconnect_0:dma_0_write_master_byteenable
	wire         dma_0_write_master_write;                                  // dma_0:write_write_n -> mm_interconnect_0:dma_0_write_master_write
	wire  [31:0] dma_0_write_master_writedata;                              // dma_0:write_writedata -> mm_interconnect_0:dma_0_write_master_writedata
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect;  // mm_interconnect_0:jtag_uart_avalon_jtag_slave_chipselect -> jtag_uart:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata;    // jtag_uart:av_readdata -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest; // jtag_uart:av_waitrequest -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_address;     // mm_interconnect_0:jtag_uart_avalon_jtag_slave_address -> jtag_uart:av_address
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_read;        // mm_interconnect_0:jtag_uart_avalon_jtag_slave_read -> jtag_uart:av_read_n
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_write;       // mm_interconnect_0:jtag_uart_avalon_jtag_slave_write -> jtag_uart:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata;   // mm_interconnect_0:jtag_uart_avalon_jtag_slave_writedata -> jtag_uart:av_writedata
	wire  [31:0] mm_interconnect_0_f_of_x_0_avalon_slave_0_readdata;        // f_of_x_0:readdata -> mm_interconnect_0:f_of_x_0_avalon_slave_0_readdata
	wire   [0:0] mm_interconnect_0_f_of_x_0_avalon_slave_0_address;         // mm_interconnect_0:f_of_x_0_avalon_slave_0_address -> f_of_x_0:address
	wire         mm_interconnect_0_f_of_x_0_avalon_slave_0_read;            // mm_interconnect_0:f_of_x_0_avalon_slave_0_read -> f_of_x_0:read
	wire         mm_interconnect_0_f_of_x_0_avalon_slave_0_write;           // mm_interconnect_0:f_of_x_0_avalon_slave_0_write -> f_of_x_0:write
	wire  [31:0] mm_interconnect_0_f_of_x_0_avalon_slave_0_writedata;       // mm_interconnect_0:f_of_x_0_avalon_slave_0_writedata -> f_of_x_0:writedata
	wire         mm_interconnect_0_dma_0_control_port_slave_chipselect;     // mm_interconnect_0:dma_0_control_port_slave_chipselect -> dma_0:dma_ctl_chipselect
	wire  [23:0] mm_interconnect_0_dma_0_control_port_slave_readdata;       // dma_0:dma_ctl_readdata -> mm_interconnect_0:dma_0_control_port_slave_readdata
	wire   [2:0] mm_interconnect_0_dma_0_control_port_slave_address;        // mm_interconnect_0:dma_0_control_port_slave_address -> dma_0:dma_ctl_address
	wire         mm_interconnect_0_dma_0_control_port_slave_write;          // mm_interconnect_0:dma_0_control_port_slave_write -> dma_0:dma_ctl_write_n
	wire  [23:0] mm_interconnect_0_dma_0_control_port_slave_writedata;      // mm_interconnect_0:dma_0_control_port_slave_writedata -> dma_0:dma_ctl_writedata
	wire  [31:0] mm_interconnect_0_sysid_control_slave_readdata;            // sysid:readdata -> mm_interconnect_0:sysid_control_slave_readdata
	wire   [0:0] mm_interconnect_0_sysid_control_slave_address;             // mm_interconnect_0:sysid_control_slave_address -> sysid:address
	wire  [31:0] mm_interconnect_0_cpu_debug_mem_slave_readdata;            // cpu:debug_mem_slave_readdata -> mm_interconnect_0:cpu_debug_mem_slave_readdata
	wire         mm_interconnect_0_cpu_debug_mem_slave_waitrequest;         // cpu:debug_mem_slave_waitrequest -> mm_interconnect_0:cpu_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_cpu_debug_mem_slave_debugaccess;         // mm_interconnect_0:cpu_debug_mem_slave_debugaccess -> cpu:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_cpu_debug_mem_slave_address;             // mm_interconnect_0:cpu_debug_mem_slave_address -> cpu:debug_mem_slave_address
	wire         mm_interconnect_0_cpu_debug_mem_slave_read;                // mm_interconnect_0:cpu_debug_mem_slave_read -> cpu:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_cpu_debug_mem_slave_byteenable;          // mm_interconnect_0:cpu_debug_mem_slave_byteenable -> cpu:debug_mem_slave_byteenable
	wire         mm_interconnect_0_cpu_debug_mem_slave_write;               // mm_interconnect_0:cpu_debug_mem_slave_write -> cpu:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_cpu_debug_mem_slave_writedata;           // mm_interconnect_0:cpu_debug_mem_slave_writedata -> cpu:debug_mem_slave_writedata
	wire         mm_interconnect_0_sys_clk_timer_s1_chipselect;             // mm_interconnect_0:sys_clk_timer_s1_chipselect -> sys_clk_timer:chipselect
	wire  [15:0] mm_interconnect_0_sys_clk_timer_s1_readdata;               // sys_clk_timer:readdata -> mm_interconnect_0:sys_clk_timer_s1_readdata
	wire   [2:0] mm_interconnect_0_sys_clk_timer_s1_address;                // mm_interconnect_0:sys_clk_timer_s1_address -> sys_clk_timer:address
	wire         mm_interconnect_0_sys_clk_timer_s1_write;                  // mm_interconnect_0:sys_clk_timer_s1_write -> sys_clk_timer:write_n
	wire  [15:0] mm_interconnect_0_sys_clk_timer_s1_writedata;              // mm_interconnect_0:sys_clk_timer_s1_writedata -> sys_clk_timer:writedata
	wire         mm_interconnect_0_led_pio_s1_chipselect;                   // mm_interconnect_0:led_pio_s1_chipselect -> led_pio:chipselect
	wire  [31:0] mm_interconnect_0_led_pio_s1_readdata;                     // led_pio:readdata -> mm_interconnect_0:led_pio_s1_readdata
	wire   [1:0] mm_interconnect_0_led_pio_s1_address;                      // mm_interconnect_0:led_pio_s1_address -> led_pio:address
	wire         mm_interconnect_0_led_pio_s1_write;                        // mm_interconnect_0:led_pio_s1_write -> led_pio:write_n
	wire  [31:0] mm_interconnect_0_led_pio_s1_writedata;                    // mm_interconnect_0:led_pio_s1_writedata -> led_pio:writedata
	wire         mm_interconnect_0_sdram_s1_chipselect;                     // mm_interconnect_0:sdram_s1_chipselect -> sdram:az_cs
	wire  [15:0] mm_interconnect_0_sdram_s1_readdata;                       // sdram:za_data -> mm_interconnect_0:sdram_s1_readdata
	wire         mm_interconnect_0_sdram_s1_waitrequest;                    // sdram:za_waitrequest -> mm_interconnect_0:sdram_s1_waitrequest
	wire  [21:0] mm_interconnect_0_sdram_s1_address;                        // mm_interconnect_0:sdram_s1_address -> sdram:az_addr
	wire         mm_interconnect_0_sdram_s1_read;                           // mm_interconnect_0:sdram_s1_read -> sdram:az_rd_n
	wire   [1:0] mm_interconnect_0_sdram_s1_byteenable;                     // mm_interconnect_0:sdram_s1_byteenable -> sdram:az_be_n
	wire         mm_interconnect_0_sdram_s1_readdatavalid;                  // sdram:za_valid -> mm_interconnect_0:sdram_s1_readdatavalid
	wire         mm_interconnect_0_sdram_s1_write;                          // mm_interconnect_0:sdram_s1_write -> sdram:az_wr_n
	wire  [15:0] mm_interconnect_0_sdram_s1_writedata;                      // mm_interconnect_0:sdram_s1_writedata -> sdram:az_data
	wire         irq_mapper_receiver0_irq;                                  // sys_clk_timer:irq -> irq_mapper:receiver0_irq
	wire         irq_mapper_receiver1_irq;                                  // jtag_uart:av_irq -> irq_mapper:receiver1_irq
	wire         irq_mapper_receiver2_irq;                                  // dma_0:dma_ctl_irq -> irq_mapper:receiver2_irq
	wire  [31:0] cpu_irq_irq;                                               // irq_mapper:sender_irq -> cpu:irq
	wire         rst_controller_reset_out_reset;                            // rst_controller:reset_out -> [cpu:reset_n, dma_0:system_reset_n, f_of_x_0:reset_n, irq_mapper:reset, jtag_uart:rst_n, led_pio:reset_n, mm_interconnect_0:cpu_reset_reset_bridge_in_reset_reset, rst_translator:in_reset, sdram:reset_n, sys_clk_timer:reset_n, sysid:reset_n]
	wire         rst_controller_reset_out_reset_req;                        // rst_controller:reset_req -> [cpu:reset_req, rst_translator:reset_req_in]

	first_nios2_system_cpu cpu (
		.clk                                 (pll_0_outclk0_clk),                                 //                       clk.clk
		.reset_n                             (~rst_controller_reset_out_reset),                   //                     reset.reset_n
		.reset_req                           (rst_controller_reset_out_reset_req),                //                          .reset_req
		.d_address                           (cpu_data_master_address),                           //               data_master.address
		.d_byteenable                        (cpu_data_master_byteenable),                        //                          .byteenable
		.d_read                              (cpu_data_master_read),                              //                          .read
		.d_readdata                          (cpu_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (cpu_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (cpu_data_master_write),                             //                          .write
		.d_writedata                         (cpu_data_master_writedata),                         //                          .writedata
		.d_readdatavalid                     (cpu_data_master_readdatavalid),                     //                          .readdatavalid
		.debug_mem_slave_debugaccess_to_roms (cpu_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (cpu_instruction_master_address),                    //        instruction_master.address
		.i_read                              (cpu_instruction_master_read),                       //                          .read
		.i_readdata                          (cpu_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (cpu_instruction_master_waitrequest),                //                          .waitrequest
		.i_readdatavalid                     (cpu_instruction_master_readdatavalid),              //                          .readdatavalid
		.irq                                 (cpu_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (),                                                  //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_cpu_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_cpu_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_cpu_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_cpu_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_cpu_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_cpu_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_cpu_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_cpu_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                   // custom_instruction_master.readra
	);

	first_nios2_system_dma_0 dma_0 (
		.clk                (pll_0_outclk0_clk),                                     //                clk.clk
		.system_reset_n     (~rst_controller_reset_out_reset),                       //              reset.reset_n
		.dma_ctl_address    (mm_interconnect_0_dma_0_control_port_slave_address),    // control_port_slave.address
		.dma_ctl_chipselect (mm_interconnect_0_dma_0_control_port_slave_chipselect), //                   .chipselect
		.dma_ctl_readdata   (mm_interconnect_0_dma_0_control_port_slave_readdata),   //                   .readdata
		.dma_ctl_write_n    (~mm_interconnect_0_dma_0_control_port_slave_write),     //                   .write_n
		.dma_ctl_writedata  (mm_interconnect_0_dma_0_control_port_slave_writedata),  //                   .writedata
		.dma_ctl_irq        (irq_mapper_receiver2_irq),                              //                irq.irq
		.read_address       (dma_0_read_master_address),                             //        read_master.address
		.read_chipselect    (dma_0_read_master_chipselect),                          //                   .chipselect
		.read_read_n        (dma_0_read_master_read),                                //                   .read_n
		.read_readdata      (dma_0_read_master_readdata),                            //                   .readdata
		.read_readdatavalid (dma_0_read_master_readdatavalid),                       //                   .readdatavalid
		.read_waitrequest   (dma_0_read_master_waitrequest),                         //                   .waitrequest
		.write_address      (dma_0_write_master_address),                            //       write_master.address
		.write_chipselect   (dma_0_write_master_chipselect),                         //                   .chipselect
		.write_waitrequest  (dma_0_write_master_waitrequest),                        //                   .waitrequest
		.write_write_n      (dma_0_write_master_write),                              //                   .write_n
		.write_writedata    (dma_0_write_master_writedata),                          //                   .writedata
		.write_byteenable   (dma_0_write_master_byteenable)                          //                   .byteenable
	);

	top f_of_x_0 (
		.clk       (pll_0_outclk0_clk),                                   //          clock.clk
		.reset_n   (~rst_controller_reset_out_reset),                     //          reset.reset_n
		.read      (mm_interconnect_0_f_of_x_0_avalon_slave_0_read),      // avalon_slave_0.read
		.write     (mm_interconnect_0_f_of_x_0_avalon_slave_0_write),     //               .write
		.writedata (mm_interconnect_0_f_of_x_0_avalon_slave_0_writedata), //               .writedata
		.address   (mm_interconnect_0_f_of_x_0_avalon_slave_0_address),   //               .address
		.readdata  (mm_interconnect_0_f_of_x_0_avalon_slave_0_readdata)   //               .readdata
	);

	first_nios2_system_jtag_uart jtag_uart (
		.clk            (pll_0_outclk0_clk),                                         //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                           //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver1_irq)                                   //               irq.irq
	);

	first_nios2_system_led_pio led_pio (
		.clk        (pll_0_outclk0_clk),                       //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),         //               reset.reset_n
		.address    (mm_interconnect_0_led_pio_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_led_pio_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_led_pio_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_led_pio_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_led_pio_s1_readdata),   //                    .readdata
		.out_port   (led_pio_external_connection_export)       // external_connection.export
	);

	first_nios2_system_pll_0 pll_0 (
		.refclk   (clk_clk),           //  refclk.clk
		.rst      (~reset_reset_n),    //   reset.reset
		.outclk_0 (pll_0_outclk0_clk), // outclk0.clk
		.outclk_1 (dram_clk_clk),      // outclk1.clk
		.locked   ()                   // (terminated)
	);

	first_nios2_system_sdram sdram (
		.clk            (pll_0_outclk0_clk),                        //   clk.clk
		.reset_n        (~rst_controller_reset_out_reset),          // reset.reset_n
		.az_addr        (mm_interconnect_0_sdram_s1_address),       //    s1.address
		.az_be_n        (~mm_interconnect_0_sdram_s1_byteenable),   //      .byteenable_n
		.az_cs          (mm_interconnect_0_sdram_s1_chipselect),    //      .chipselect
		.az_data        (mm_interconnect_0_sdram_s1_writedata),     //      .writedata
		.az_rd_n        (~mm_interconnect_0_sdram_s1_read),         //      .read_n
		.az_wr_n        (~mm_interconnect_0_sdram_s1_write),        //      .write_n
		.za_data        (mm_interconnect_0_sdram_s1_readdata),      //      .readdata
		.za_valid       (mm_interconnect_0_sdram_s1_readdatavalid), //      .readdatavalid
		.za_waitrequest (mm_interconnect_0_sdram_s1_waitrequest),   //      .waitrequest
		.zs_addr        (sdram_wire_addr),                          //  wire.export
		.zs_ba          (sdram_wire_ba),                            //      .export
		.zs_cas_n       (sdram_wire_cas_n),                         //      .export
		.zs_cke         (sdram_wire_cke),                           //      .export
		.zs_cs_n        (sdram_wire_cs_n),                          //      .export
		.zs_dq          (sdram_wire_dq),                            //      .export
		.zs_dqm         (sdram_wire_dqm),                           //      .export
		.zs_ras_n       (sdram_wire_ras_n),                         //      .export
		.zs_we_n        (sdram_wire_we_n)                           //      .export
	);

	first_nios2_system_sys_clk_timer sys_clk_timer (
		.clk        (pll_0_outclk0_clk),                             //   clk.clk
		.reset_n    (~rst_controller_reset_out_reset),               // reset.reset_n
		.address    (mm_interconnect_0_sys_clk_timer_s1_address),    //    s1.address
		.writedata  (mm_interconnect_0_sys_clk_timer_s1_writedata),  //      .writedata
		.readdata   (mm_interconnect_0_sys_clk_timer_s1_readdata),   //      .readdata
		.chipselect (mm_interconnect_0_sys_clk_timer_s1_chipselect), //      .chipselect
		.write_n    (~mm_interconnect_0_sys_clk_timer_s1_write),     //      .write_n
		.irq        (irq_mapper_receiver0_irq)                       //   irq.irq
	);

	first_nios2_system_sysid sysid (
		.clock    (pll_0_outclk0_clk),                              //           clk.clk
		.reset_n  (~rst_controller_reset_out_reset),                //         reset.reset_n
		.readdata (mm_interconnect_0_sysid_control_slave_readdata), // control_slave.readdata
		.address  (mm_interconnect_0_sysid_control_slave_address)   //              .address
	);

	first_nios2_system_mm_interconnect_0 mm_interconnect_0 (
		.pll_0_outclk0_clk                       (pll_0_outclk0_clk),                                         //                   pll_0_outclk0.clk
		.cpu_reset_reset_bridge_in_reset_reset   (rst_controller_reset_out_reset),                            // cpu_reset_reset_bridge_in_reset.reset
		.cpu_data_master_address                 (cpu_data_master_address),                                   //                 cpu_data_master.address
		.cpu_data_master_waitrequest             (cpu_data_master_waitrequest),                               //                                .waitrequest
		.cpu_data_master_byteenable              (cpu_data_master_byteenable),                                //                                .byteenable
		.cpu_data_master_read                    (cpu_data_master_read),                                      //                                .read
		.cpu_data_master_readdata                (cpu_data_master_readdata),                                  //                                .readdata
		.cpu_data_master_readdatavalid           (cpu_data_master_readdatavalid),                             //                                .readdatavalid
		.cpu_data_master_write                   (cpu_data_master_write),                                     //                                .write
		.cpu_data_master_writedata               (cpu_data_master_writedata),                                 //                                .writedata
		.cpu_data_master_debugaccess             (cpu_data_master_debugaccess),                               //                                .debugaccess
		.cpu_instruction_master_address          (cpu_instruction_master_address),                            //          cpu_instruction_master.address
		.cpu_instruction_master_waitrequest      (cpu_instruction_master_waitrequest),                        //                                .waitrequest
		.cpu_instruction_master_read             (cpu_instruction_master_read),                               //                                .read
		.cpu_instruction_master_readdata         (cpu_instruction_master_readdata),                           //                                .readdata
		.cpu_instruction_master_readdatavalid    (cpu_instruction_master_readdatavalid),                      //                                .readdatavalid
		.dma_0_read_master_address               (dma_0_read_master_address),                                 //               dma_0_read_master.address
		.dma_0_read_master_waitrequest           (dma_0_read_master_waitrequest),                             //                                .waitrequest
		.dma_0_read_master_chipselect            (dma_0_read_master_chipselect),                              //                                .chipselect
		.dma_0_read_master_read                  (~dma_0_read_master_read),                                   //                                .read
		.dma_0_read_master_readdata              (dma_0_read_master_readdata),                                //                                .readdata
		.dma_0_read_master_readdatavalid         (dma_0_read_master_readdatavalid),                           //                                .readdatavalid
		.dma_0_write_master_address              (dma_0_write_master_address),                                //              dma_0_write_master.address
		.dma_0_write_master_waitrequest          (dma_0_write_master_waitrequest),                            //                                .waitrequest
		.dma_0_write_master_byteenable           (dma_0_write_master_byteenable),                             //                                .byteenable
		.dma_0_write_master_chipselect           (dma_0_write_master_chipselect),                             //                                .chipselect
		.dma_0_write_master_write                (~dma_0_write_master_write),                                 //                                .write
		.dma_0_write_master_writedata            (dma_0_write_master_writedata),                              //                                .writedata
		.cpu_debug_mem_slave_address             (mm_interconnect_0_cpu_debug_mem_slave_address),             //             cpu_debug_mem_slave.address
		.cpu_debug_mem_slave_write               (mm_interconnect_0_cpu_debug_mem_slave_write),               //                                .write
		.cpu_debug_mem_slave_read                (mm_interconnect_0_cpu_debug_mem_slave_read),                //                                .read
		.cpu_debug_mem_slave_readdata            (mm_interconnect_0_cpu_debug_mem_slave_readdata),            //                                .readdata
		.cpu_debug_mem_slave_writedata           (mm_interconnect_0_cpu_debug_mem_slave_writedata),           //                                .writedata
		.cpu_debug_mem_slave_byteenable          (mm_interconnect_0_cpu_debug_mem_slave_byteenable),          //                                .byteenable
		.cpu_debug_mem_slave_waitrequest         (mm_interconnect_0_cpu_debug_mem_slave_waitrequest),         //                                .waitrequest
		.cpu_debug_mem_slave_debugaccess         (mm_interconnect_0_cpu_debug_mem_slave_debugaccess),         //                                .debugaccess
		.dma_0_control_port_slave_address        (mm_interconnect_0_dma_0_control_port_slave_address),        //        dma_0_control_port_slave.address
		.dma_0_control_port_slave_write          (mm_interconnect_0_dma_0_control_port_slave_write),          //                                .write
		.dma_0_control_port_slave_readdata       (mm_interconnect_0_dma_0_control_port_slave_readdata),       //                                .readdata
		.dma_0_control_port_slave_writedata      (mm_interconnect_0_dma_0_control_port_slave_writedata),      //                                .writedata
		.dma_0_control_port_slave_chipselect     (mm_interconnect_0_dma_0_control_port_slave_chipselect),     //                                .chipselect
		.f_of_x_0_avalon_slave_0_address         (mm_interconnect_0_f_of_x_0_avalon_slave_0_address),         //         f_of_x_0_avalon_slave_0.address
		.f_of_x_0_avalon_slave_0_write           (mm_interconnect_0_f_of_x_0_avalon_slave_0_write),           //                                .write
		.f_of_x_0_avalon_slave_0_read            (mm_interconnect_0_f_of_x_0_avalon_slave_0_read),            //                                .read
		.f_of_x_0_avalon_slave_0_readdata        (mm_interconnect_0_f_of_x_0_avalon_slave_0_readdata),        //                                .readdata
		.f_of_x_0_avalon_slave_0_writedata       (mm_interconnect_0_f_of_x_0_avalon_slave_0_writedata),       //                                .writedata
		.jtag_uart_avalon_jtag_slave_address     (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),     //     jtag_uart_avalon_jtag_slave.address
		.jtag_uart_avalon_jtag_slave_write       (mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),       //                                .write
		.jtag_uart_avalon_jtag_slave_read        (mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),        //                                .read
		.jtag_uart_avalon_jtag_slave_readdata    (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),    //                                .readdata
		.jtag_uart_avalon_jtag_slave_writedata   (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),   //                                .writedata
		.jtag_uart_avalon_jtag_slave_waitrequest (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest), //                                .waitrequest
		.jtag_uart_avalon_jtag_slave_chipselect  (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),  //                                .chipselect
		.led_pio_s1_address                      (mm_interconnect_0_led_pio_s1_address),                      //                      led_pio_s1.address
		.led_pio_s1_write                        (mm_interconnect_0_led_pio_s1_write),                        //                                .write
		.led_pio_s1_readdata                     (mm_interconnect_0_led_pio_s1_readdata),                     //                                .readdata
		.led_pio_s1_writedata                    (mm_interconnect_0_led_pio_s1_writedata),                    //                                .writedata
		.led_pio_s1_chipselect                   (mm_interconnect_0_led_pio_s1_chipselect),                   //                                .chipselect
		.sdram_s1_address                        (mm_interconnect_0_sdram_s1_address),                        //                        sdram_s1.address
		.sdram_s1_write                          (mm_interconnect_0_sdram_s1_write),                          //                                .write
		.sdram_s1_read                           (mm_interconnect_0_sdram_s1_read),                           //                                .read
		.sdram_s1_readdata                       (mm_interconnect_0_sdram_s1_readdata),                       //                                .readdata
		.sdram_s1_writedata                      (mm_interconnect_0_sdram_s1_writedata),                      //                                .writedata
		.sdram_s1_byteenable                     (mm_interconnect_0_sdram_s1_byteenable),                     //                                .byteenable
		.sdram_s1_readdatavalid                  (mm_interconnect_0_sdram_s1_readdatavalid),                  //                                .readdatavalid
		.sdram_s1_waitrequest                    (mm_interconnect_0_sdram_s1_waitrequest),                    //                                .waitrequest
		.sdram_s1_chipselect                     (mm_interconnect_0_sdram_s1_chipselect),                     //                                .chipselect
		.sys_clk_timer_s1_address                (mm_interconnect_0_sys_clk_timer_s1_address),                //                sys_clk_timer_s1.address
		.sys_clk_timer_s1_write                  (mm_interconnect_0_sys_clk_timer_s1_write),                  //                                .write
		.sys_clk_timer_s1_readdata               (mm_interconnect_0_sys_clk_timer_s1_readdata),               //                                .readdata
		.sys_clk_timer_s1_writedata              (mm_interconnect_0_sys_clk_timer_s1_writedata),              //                                .writedata
		.sys_clk_timer_s1_chipselect             (mm_interconnect_0_sys_clk_timer_s1_chipselect),             //                                .chipselect
		.sysid_control_slave_address             (mm_interconnect_0_sysid_control_slave_address),             //             sysid_control_slave.address
		.sysid_control_slave_readdata            (mm_interconnect_0_sysid_control_slave_readdata)             //                                .readdata
	);

	first_nios2_system_irq_mapper irq_mapper (
		.clk           (pll_0_outclk0_clk),              //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.receiver1_irq (irq_mapper_receiver1_irq),       // receiver1.irq
		.receiver2_irq (irq_mapper_receiver2_irq),       // receiver2.irq
		.sender_irq    (cpu_irq_irq)                     //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.clk            (pll_0_outclk0_clk),                  //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
