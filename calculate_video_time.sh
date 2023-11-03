#!/bin/bash

# 定义一个函数，将秒数转换为时分秒格式
function format_time() {
  local time=$1    
  local hours=$((time / 3600))
  local minutes=$(( (time % 3600) / 60 | bc))
  local seconds=$((time % 60))
  printf "%02d:%02d:%02d\n" $hours $minutes $seconds
}
# 初始化一个变量，用于存储总时长
total_duration=0
video_directory=$1
# video_directory="/Users/jianzhounie/java架构师/java直通车/阶段三：分布式架构-逐个击破分布式核心问题（9-17周）/12/*.mp4"
if [ -z "$video_directory" ]; then
  echo "第一个参数，目录地址为空，请输入："
  read video_directory
else
  echo "要计算视频总时长的目录: $video_directory"
fi
# 遍历目录下的所有mp4文件
for file in $video_directory
do
  # 使用ffprobe获取每个文件的时长，以秒为单位
  duration=$(ffprobe -i "$file" -show_entries format=duration -v quiet -of csv="p=0")
  # 将时长累加到总时长变量中
  total_duration=$(echo "($total_duration + $duration)/1" | bc)
done
# 调用函数，将总时长转换为时分秒格式
formatted_duration=$(format_time $total_duration)

# 输出结果
echo "目录下所有mp4的总时长为：$formatted_duration"
 
