create_clock -period 2.5 PCLK
set_input_delay 0.1 -clock PCLK [get_ports {*}]
set_output_delay 0.1 -clock PCLK [get_ports {*}]


set_clock_uncertainty 0.298
