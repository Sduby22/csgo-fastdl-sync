# csgo-fastdl-sync
sync server file with fastdl cos server 同步csgo服务器资源文件与fastdl对象存储

使用腾讯云COS作为fastdl服务器，需要用到腾讯云的coscmd工具

`update_fastdl.sh`大于150m的文件直接上传，小于150m的文件压缩上传

`remove_150M_bz2.sh`若服务器上存在大于150m文件的压缩包，则删除
