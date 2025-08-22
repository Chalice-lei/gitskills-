#!/bin/bash
# 单个C++文件的构建脚本（适用于test.cpp）

# 配置参数
SRC_FILE="test.cpp"
OUTPUT_FILE="test"
CXX="g++"
CXXFLAGS="-std=c++17 -Wall -Wextra -O2"  # C++17标准，开启警告，优化级别2
LDFLAGS=""  # 链接器参数，如需链接库可添加（如-lm, -lpthread等）

# 检查源文件是否存在
if [ ! -f "$SRC_FILE" ]; then
    echo "错误: 源文件 $SRC_FILE 不存在!"
    exit 1
fi

# 构建命令
build() {
    echo "正在编译 $SRC_FILE..."
    $CXX $CXXFLAGS $SRC_FILE -o $OUTPUT_FILE $LDFLAGS
    
    if [ $? -eq 0 ]; then
        echo "编译成功! 可执行文件: $OUTPUT_FILE"
    else
        echo "编译失败"
        exit 1
    fi
}

# 清理命令
clean() {
    if [ -f "$OUTPUT_FILE" ]; then
        rm -f "$OUTPUT_FILE"
        echo "已删除可执行文件: $OUTPUT_FILE"
    else
        echo "没有可清理的文件"
    fi
}

# 运行程序
run() {
    if [ -f "$OUTPUT_FILE" ]; then
        echo "正在运行 $OUTPUT_FILE..."
        ./$OUTPUT_FILE
    else
        echo "可执行文件不存在，请先编译"
        exit 1
    fi
}

# 显示帮助信息
usage() {
    echo "用法: $0 [命令]"
    echo "命令:"
    echo "  (无参数)   编译程序"
    echo "  clean      清理可执行文件"
    echo "  run        运行程序（需先编译）"
    echo "  help       显示帮助信息"
}

# 根据参数执行相应操作
case "$1" in
    clean)
        clean
        ;;
    run)
        run
        ;;
    help)
        usage
        ;;
    "")
        build
        ;;
    *)
        echo "未知命令: $1"
        usage
        exit 1
        ;;
esac

