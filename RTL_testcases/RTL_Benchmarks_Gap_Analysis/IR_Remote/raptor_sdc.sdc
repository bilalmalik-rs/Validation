create_clock -period 2.5 Clock_i
set_input_delay 0 -clock Clock_i [get_ports {*}]
set_output_delay 0 -clock Clock_i [get_ports {*}]


set_clock_uncertainty 0.298
