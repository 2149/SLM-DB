#!/bin/bash
value_array=(4096)
test_all_size="`expr 20 \* 1024 \* 1024 \* 1024`"
bench_db_path=/mnt/HDD/xxl/test
bench_value="4096"
bench_compression="none"
bench_benchmarks="fillrandom,stats,waitcompaction,clean_cache,stats,csv,readrandom,stats,waitcompaction,clean_cache,stats,scanrandom,waitcompaction,clean_cache,stats,csv,sstables"
bench_num="20000000"
bench_readnum="1000000"
buffer_size="`expr 64 \* 1024 \* 1024`"
max_file_size="`expr 64 \* 1024 \* 1024`"
threads="1"
merge_ratio="70"
nvm_size="`expr 8 \* 1024 `"

pmem_path="/mnt/pmem1/xxltest/slm"

bench_file_path="/mnt/HDD/xxl/SLM-DB/build/db_bench"

result_dir="/mnt/HDD/xxl/SLM-DB/results"

RUN_ONE_TEST() {
    const_params="
    --db=$bench_db_path \
    --threads=$threads \
    --value_size=$bench_value \
    --benchmarks=$bench_benchmarks \
    --num=$bench_num \
    --reads=$bench_readnum \
	--write_buffer_size=$buffer_size \
	--max_file_size=$max_file_size \
    --nvm_dir=$pmem_path \
	--nvm_size=$nvm_size \
	--merge_ratio=$merge_ratio \
	--range_size=100 \
    --compression_ratio=1.0
    "
    cmd="$bench_file_path $const_params >>out.out 2>&1"
    echo $cmd >out.out
    echo $cmd
    eval $cmd
}


CLEAN_CACHE() {
    if [ -n "$bench_db_path" ];then
        rm -f $bench_db_path/*
    fi
	rm -rf $pmem_path
    sleep 2
    sync
    echo 3 > /proc/sys/vm/drop_caches
    sleep 2
}

COPY_OUT_FILE(){
	res_dir_parent=$result_dir/result-$(date +%d%H%I%M%S)
    mkdir $res_dir_parent > /dev/null 2>&1
    res_dir=$res_dir_parent/value-$bench_value
    mkdir $res_dir > /dev/null 2>&1
    \cp -f $result_dir/out.out $res_dir/
}
RUN_ALL_TEST() {
    for value in ${value_array[@]}; do
        CLEAN_CACHE
        bench_value="$value"
        bench_num="`expr $test_all_size \/ $bench_value`"
		bench_readnum="`expr $bench_num \/ 10`"

        RUN_ONE_TEST
        if [ $? -ne 0 ];then
            exit 1
        fi
        COPY_OUT_FILE
        sleep 5
    done
}

RUN_ALL_TEST


