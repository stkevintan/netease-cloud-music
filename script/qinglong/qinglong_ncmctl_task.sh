#!/usr/bin/env bash

################################################################################
# MIT License
#
# Copyright (c) 2024 chaunsin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
################################################################################

# name: ncmctl一键任务执行
# cron: 0 10 * * *

########################################################################
# 注意:                                                                 #
#  1.需要提前安装`ncmctl`可执行文件                                        #
#  2.执行前需要保证登录状态,也就是走完`ncmctl login qrcode`流程               #
#  3.音乐合伙人资格不是所有人都有,因此如果没有此功能则需要注释掉配置，不然会出现错误。#
#########################################################################

set -e

# 定义环境变量任务开关,默认开启
NCMCTL_QINGLONG_SIGN=${NCMCTL_QINGLONG_SIGN:-true}
NCMCTL_QINGLONG_SCROBBLE=${NCMCTL_QINGLONG_SCROBBLE:-true}
NCMCTL_QINGLONG_PARTNER=${NCMCTL_QINGLONG_PARTNER:-true}

# 将变量值转换为小写
to_lower() {
  echo "$1" | tr '[:upper:]' '[:lower:]'
}

# 执行每日云贝签到任务
if [[ "$(to_lower "${NCMCTL_QINGLONG_SIGN}")" == "true" ]]; then
  echo ">>> 执行每日云贝签到任务 <<<"
  ncmctl sign
  echo "--- 执行每日云贝签到任务完成 ---"
fi

# 执行刷歌任务,注意如果已经刷到了满级则需要关闭此功能，不然会出现封号风险。
if [[ "$(to_lower "${NCMCTL_QINGLONG_SCROBBLE}")" == "true" ]]; then
  echo ">>> 执行刷歌任务 <<<"
  ncmctl scrobble
  echo "--- 执行刷歌任务完成 ---"
fi

# 执行音乐合伙人签到任务,注意如果有没有此功能权限则设置为false，不然会出现错误。
if [[ "$(to_lower "${NCMCTL_QINGLONG_PARTNER}")" == "true" ]]; then
  echo ">>> 执行音乐合伙人签到任务 <<<"
  ncmctl partner
  echo "--- 执行音乐合伙人签到任务完成 ---"
fi

