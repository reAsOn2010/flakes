docker run -d --privileged \
    -v ~/Documents/redroid:/data \
    -p 5555:5555 \
    --name redroid11 \
    redroid/redroid:11.0.0-latest \
    androidboot.redroid_gpu_mode=host \
    androidboot.redroid_fps=120 \
    androidboot.use_memfd=true
