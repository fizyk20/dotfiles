-- vim: ts=4 sw=4 noet ai cindent syntax=lua
--[[
Conky, a system monitor, based on torsmo

Any original torsmo code is licensed under the BSD license

All code written since the fork of torsmo is licensed under the GPL

Please see COPYING for details

Copyright (c) 2004, Hannu Saransaari and Lauri Hakkarainen
Copyright (c) 2005-2012 Brenden Matthews, Philip Kovacs, et. al. (see AUTHORS)
All rights reserved.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

conky.config = {
	out_to_x = false,
    own_window = false,
    out_to_console = true,
    out_to_stderr = false,
    background = false,
	max_text_width = 0,

    update_interval = 1.0,

	total_run_times = 0,

	short_units = true,

	if_up_strictness = 'address',

    use_spacer = 'none',

	override_utf8_locale = false,

    cpu_avg_samples = 2,
    net_avg_samples = 2,

	default_color = 'white',
    default_outline_color = 'white',
    default_shade_color = 'white',
    no_buffers = true,
}

conky.text = [[
[
 { "full_text": "Warszawa: ${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ EPWA weather} ${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ EPWA temperature}°C, ${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ EPWA humidity}% humidity, ${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ EPWA pressure} mbar, wind ${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ EPWA wind_speed}km/h ", "color": "\#ffffff" },
 { "full_text": "HDD ${fs_free /home} free", "color": "\#ffffff" },
 { "full_text": "RAM ${memperc}%", "color": ${if_match ${memperc}<75}"\#00ff00"${else}${if_match ${memperc}<90}"\#ffff00"${else}"\#ff0000"${endif}${endif} },

${if_up wlp5s0}
 { "full_text": "WiFi: (${if_match ${wireless_link_qual_perc wlp5s0}<100} ${endif}${wireless_link_qual_perc wlp5s0}% at ${wireless_essid wlp5s0}) ${addr wlp5s0}", "align": "left", "color": ${if_match ${wireless_link_qual_perc wlp5s0}<40}"\#ff0000"${else}${if_match ${wireless_link_qual_perc wlp5s0}<50}"\ffff00"${else}"\#00ff00"${endif}${endif} },
${endif}

${if_up enp3s0}
 { "full_text": "Eth: ${addr enp3s0}", "color": "\#00ff00" },
${endif}

${if_up tun0}
 { "full_text": "VPN: ${addr tun0}", "color": "\#00ff00" },
${endif}

 { "full_text": "${battery_short BAT1} ${battery_time BAT1}", "color": ${if_match ${battery_percent BAT1}>50}"\#ffffff"${else}${if_match ${battery_percent BAT1}>25}"\#ffff00"${else}"\#ff0000"${endif}${endif} },
 { "full_text": "CPU: ${cpu}%", "min_width": "CPU: 100%", "align": "left", "color": "\#ffffff" },
 { "full_text": "♪: ${if_pa_sink_muted}(muted) ${endif}${pa_sink_volume}%", "color": ${if_pa_sink_muted}"\#ffff00"${else}"\#ffffff"${endif} },
 { "full_text": "${time %Y-%m-%d %H:%M:%S}", "color": "\#ffffff", "name": "time" }
],
]]
