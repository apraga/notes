#gentoo
Pourquoi ? Mieux que pulseaudio.
1. Suivre le guide sur gentoo 
2. Pour changer l'entrée 

❯ pactl get-default-sink
alsa_output.pci-0000_00_1b.0.iec958-stereo

❯ pactl list short sinks
49	alsa_output.pci-0000_01_00.1.hdmi-stereo	PipeWire	s32le 2ch 48000Hz	SUSPENDED
50	alsa_output.pci-0000_00_1b.0.iec958-stereo	PipeWire	s32le 2ch 48000Hz	SUSPENDED

❯ pactl set-default-sink 49
❯ pactl get-default-sink
alsa_output.pci-0000_01_00.1.hdmi-stereo

Augmenter le volume
pactl set-sink-volume @DEFAULT_SINK@ +5%
