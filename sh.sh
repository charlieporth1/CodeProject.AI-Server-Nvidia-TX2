#!/bin/bash
		name=ai-server
		tag=arm64
		# tag=latest
		# tag=cuda12_2-2.9.7

		docker pull codeproject/$name:$tag
		docker run \
			--name CodeProject.$name \
			--runtime=nvidia \
		 	--gpus all \
			--restart always \
  			--privileged \
  			--network=host \
			--cpuset-cpus=0-5 \
			--device /dev/fb0:/dev/fb0 \
			--device /dev/fb:/dev/fb \
			--device /dev/nvhdcp0:/dev/nvhdcp0 \
			--device /dev/gpu_freq_max:/dev/gpu_freq_max \
			--device /dev/gpu_freq_min:/dev/gpu_freq_min \
			--device /dev/camchar-dbg:/dev/camchar-dbg \
			--device /dev/camchar-echo:/dev/camchar-echo \
			--device /dev/capture-vi-channel0:/dev/capture-vi-channel0 \
			--device /dev/capture-vi-channel1:/dev/capture-vi-channel1 \
			--device /dev/capture-vi-channel2:/dev/capture-vi-channel2 \
			--device /dev/capture-vi-channel3:/dev/capture-vi-channel3 \
			--device /dev/capture-vi-channel4:/dev/capture-vi-channel4 \
			--device /dev/capture-vi-channel5:/dev/capture-vi-channel5 \
			--device /dev/capture-vi-channel6:/dev/capture-vi-channel6 \
			--device /dev/capture-vi-channel7:/dev/capture-vi-channel7 \
			--device /dev/capture-vi-channel8:/dev/capture-vi-channel8 \
			--device /dev/capture-vi-channel9:/dev/capture-vi-channel9 \
			--device /dev/capture-vi-channel10:/dev/capture-vi-channel10 \
			--device /dev/capture-vi-channel11:/dev/capture-vi-channel11 \
			--device /dev/capture-vi-channel12:/dev/capture-vi-channel12 \
			--device /dev/capture-vi-channel13:/dev/capture-vi-channel13 \
			--device /dev/capture-vi-channel14:/dev/capture-vi-channel14 \
			--device /dev/media0:/dev/media0 \
			--device /dev/nvhost-as-gpu:/dev/nvhost-as-gpu \
			--device /dev/nvhost-ctrl:/dev/nvhost-ctrl \
			--device /dev/nvhost-ctrl-gpu:/dev/nvhost-ctrl-gpu \
			--device /dev/nvhost-ctrl-isp:/dev/nvhost-ctrl-isp \
			--device /dev/nvhost-ctrl-nvcsi:/dev/nvhost-ctrl-nvcsi \
			--device /dev/nvhost-ctrl-nvdec:/dev/nvhost-ctrl-nvdec \
			--device /dev/nvhost-ctxsw-gpu:/dev/nvhost-ctxsw-gpu \
			--device /dev/nvhost-dbg-gpu:/dev/nvhost-dbg-gpu \
			--device /dev/nvhost-gpu:/dev/nvhost-gpu \
			--device /dev/nvhost-isp:/dev/nvhost-isp \
			--device /dev/nvhost-msenc:/dev/nvhost-msenc \
			--device /dev/nvhost-nvcsi:/dev/nvhost-nvcsi \
			--device /dev/nvhost-nvdec:/dev/nvhost-nvdec \
			--device /dev/nvhost-nvjpg:/dev/nvhost-nvjpg \
			--device /dev/nvhost-prof-gpu:/dev/nvhost-prof-gpu \
			--device /dev/nvhost-sched-gpu:/dev/nvhost-sched-gpu \
			--device /dev/nvhost-tsec:/dev/nvhost-tsec \
			--device /dev/nvhost-tsecb:/dev/nvhost-tsecb \
			--device /dev/nvhost-tsg-gpu:/dev/nvhost-tsg-gpu \
			--device /dev/nvhost-vi:/dev/nvhost-vi \
			--device /dev/nvhost-vic:/dev/nvhost-vic \
			--device /dev/nvmap:/dev/nvmap \
			--device /dev/tegra_camera_ctrl:/dev/tegra_camera_ctrl \
			--device /dev/tegra-crypto:/dev/tegra-crypto \
			--device /dev/tegra_dc_0:/dev/tegra_dc_0 \
			--device /dev/tegra_dc_ctrl:/dev/tegra_dc_ctrl \
			--device /dev/tegra_mipi_cal:/dev/tegra_mipi_cal \
			--device /dev/tegra-vi0-channel0:/dev/tegra-vi0-channel0 \
			--device /dev/tegra-vi0-channel1:/dev/tegra-vi0-channel1 \
			--device /dev/tegra-vi0-channel2:/dev/tegra-vi0-channel2 \
			--device /dev/tegra-vi0-channel3:/dev/tegra-vi0-channel3 \
			--device /dev/tegra-vi0-channel4:/dev/tegra-vi0-channel4 \
			--device /dev/tegra-vi0-channel5:/dev/tegra-vi0-channel5 \
			--device /dev/tegra-vi0-channel6:/dev/tegra-vi0-channel6 \
			--device /dev/tegra-vi0-channel7:/dev/tegra-vi0-channel7 \
			--device /dev/tegra-vi0-channel8:/dev/tegra-vi0-channel8 \
			--device /dev/tegra-vi0-channel9:/dev/tegra-vi0-channel9 \
			--device /dev/tegra-vi0-channel10:/dev/tegra-vi0-channel10 \
			--device /dev/tegra-vi0-channel11:/dev/tegra-vi0-channel11 \
			--device /dev/trusty-ipc-dev0:/dev/trusty-ipc-dev0 \
			--device /dev/max_cpu_power:/dev/max_cpu_power \
			--device /dev/max_gpu_power:/dev/max_gpu_power \
			--device /dev/max_online_cpus:/dev/max_online_cpus \
			--device /dev/min_online_cpus:/dev/min_online_cpus \
			--device /dev/mem:/dev/mem \
			--device /dev/hwbinder:/dev/hwbinder \
			--device /dev/constraint_cpu_freq:/dev/constraint_cpu_freq \
			--device /dev/constraint_gpu_freq:/dev/constraint_gpu_freq \
			--device /dev/constraint_online_cpus:/dev/constraint_online_cpus \
			-d \
			-p 32168:32168 \
		  	-e TZ=Etc/UTC \
                        -e USE_CUDA=true \
                        -e FORCE_GPU=true \
			-v /lib/modules:/lib/modules \
			-v /dev:/dev \
 			-v $name-ai:/etc/codeproject/ai \
 			-v $name-modules:/app/modules \
			codeproject/$name:$tag

		dc=$( sudo docker container ls -a | grep $name | sed -n '1p' | awk '{print $1}' )
		di=$( sudo docker image ls -a | grep $name | sed -n '1p' | awk '{print $3}' )
		container_id=$(docker ps | grep $dc | awk '{print $1}')
